$nom=Read-Host -Prompt "saisir un nom d'un compte local" 
$compte=[ADSI]"WinNT://./$nom"
if ($compte.Path){
Write-Host $compte.LastLogin.ps1
Write-Host "information sup: $compte.FullName"
Write-Host "description: $compte.descrption"
}
else{
Write-Host "$nom non trouvé"
}