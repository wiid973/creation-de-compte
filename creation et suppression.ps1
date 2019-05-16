
function Connect-MySQL() { 
    # Load MySQL .NET Connector Objects 
    [void][system.reflection.Assembly]::LoadWithPartialName("MySql.Data") 
 
    # Open Connection 
    #uid = nom du compte mysql, pwd = mot de passe
    $connStr = "server=127.0.0.1;port=3306;uid=root;pwd=Admin123456789;database=ga2019;Pooling=FALSE" 
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
function Execute-MySQLQuery($conn, [string]$lesJeux) { 
  # NonQuery - Insert/Update/Delete query where no return data is required
  $cmd = New-Object MySql.Data.MySqlClient.MySqlCommand($lesJeux, $conn)    # Create SQL command
  $dataAdapter = New-Object MySql.Data.MySqlClient.MySqlDataAdapter($cmd)      # Create data adapter from query command
  $dataSet = New-Object System.Data.DataSet                                    # Create dataset
  $dataAdapter.Fill($dataSet, "data")                                          # Fill dataset from data adapter, with name "data"              
  $cmd.Dispose()
  return $dataSet.Tables["data"]                                               # Returns an array of results
}
clear
Write-Host "bonjour bienvenue la connexion de gamer assembly 2019"
Write-Host "[1] - cration de compte locale"
Write-Host "[2] - suppression de compte locale"

$choixAction = Read-Host "type de choix"
if($choixAction -eq 1)
    {
        $serveur="creation de compte locale"

        #Récupération jeux dans la base de données
        echo = "jeux enregistré dans la base de donnée"
        $conn = Connect-MySQL
        $lesJeux = "select * from jeux "
        $result = Execute-MySQLQuery $conn $lesJeux
        Write-Host ("Found " + $result.rows.count + " rows...")
        $result | Format-Table

        #Afficher et séléctionner le jeu
        $choixjeu = Read-Host "séléctionner le jeu."


        #Récupération des joueurs liés au jeu choisis dans la base de données

        $conn = Connect-MySQL
        $lesJoueurs = "select * from joueurs where idJeu = $choixjeu"
        $result = Execute-MySQLQuery $conn $lesJoueurs
        Write-Host ("Found " + $result.rows.count + " rows...")
        $result | Format-Table


        #Création des comptes
        clear
        ForEach($joueurs in $result)
        {
            $joueur=$joueurs.pseudo
            $motDePasse=$joueurs.mdp
            if($joueur -notlike "")
            {
                New-LocalUser $joueur -Password (ConvertTo-SecureString $motDePasse -AsPlainText -Force) 
            Write-Host "bonjour $joueur votre compte a bien été crée"
             }

        }
    }
else
{
clear
    if($choixAction -eq 2)
    {
        $query= "Select * from joueurs WHERE idJeu = $choixJeu"
        $result = Execute-MySQLQuery $conn $query
        ForEach($joueurs in $result)
        {
            $joueur=$joueurs.pseudo
            if($joueur -notlike "")
            {
                Remove-LocalUser $joueur -Verbose
            }
        }
    }
 }

