
function Connect-MySQL() { 
    # Load MySQL .NET Connector Objects 
    [void][system.reflection.Assembly]::LoadWithPartialName("MySql.Data") 
 
    # Open Connection 
    #uid = nom du compte mysql, pwd = mot de passe
    $connStr = "server=127.0.0.1;port=3306;uid=root;pwd=Admin12456789;database=bdd;Pooling=FALSE" 
    try {
        $conn = New-Object MySql.Data.MySqlClient.MySqlConnection($connStr) 
        $conn.Open()
    } catch [System.Management.Automation.PSArgumentException] {
        write-host "Unable to connect to MySQL server, do you have the MySQL connector installed..?"
        write-host $_
        Exit
    } catch {
        write-host "Unable to connect to MySQL server..."
        write-host $_.Exception.GetType().FullName
        write-host $_.Exception.Message
        write-host $connStr
        exit
    }
    write-host "Connected to MySQL database $MySQLHost\$database"

    return $conn 
}

#A utiliser pour les requetes INSERT, UPDATE, DELETE
function Execute-MySQLNonQuery($conn, [string]$query) { 
  $command = $conn.CreateCommand()                  # Create command object
  $command.CommandText = $query                     # Load query into object
  $RowsInserted = $command.ExecuteNonQuery()        # Execute command
  $command.Dispose()                                # Dispose of command object
  if ($RowsInserted) { 
    return $RowInserted 
  } else { 
    return $false 
  } 
} 

#A utilise pour les requetes SELECT
function Execute-MySQLQuery($conn, [string]$query) { 
  # NonQuery - Insert/Update/Delete query where no return data is required
  $cmd = New-Object MySql.Data.MySqlClient.MySqlCommand($query, $conn)    # Create SQL command
  $dataAdapter = New-Object MySql.Data.MySqlClient.MySqlDataAdapter($cmd)      # Create data adapter from query command
  $dataSet = New-Object System.Data.DataSet                                    # Create dataset
  $dataAdapter.Fill($dataSet, "data")                                          # Fill dataset from data adapter, with name "data"              
  $cmd.Dispose()
  return $dataSet.Tables["data"]                                               # Returns an array of results
}


#Exemples 
$conn = Connect-MySQL
$query = "SELECT * FROM Visiteur;"
$result = Execute-MySQLQuery $conn $query
Write-Host ("Found " + $result.rows.count + " rows...")
$result | Format-Table