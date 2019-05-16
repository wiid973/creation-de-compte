$local=[ADSI]"WinNT://."
$nom=Read-Host -prompt "saisir un nom"
$description=Read-Host -Prompt "saisir une description"
$nomcomplet=Read-Host -Prompt "saisir le nom complet"

$compte=[ADSI]"WinNT://./$nom"
Write-Host $compte.path
if (!$compte.Path){
$utilisateur=$local.Create("user",$nom)
$utilisateur.InvokeSet("FullName", $nomcomplet)
$utilisateur.InvokeSet("description",$description)
$utilisateur.CommitChanges()
Write-Host "$nom ajouté"
}
else{
Write-Host "$nom existe déja"
} 