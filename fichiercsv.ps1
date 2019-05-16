#lire un fichier 
$monFichier=Get-Content C:\Users\Administrateur\Desktop\kaki\user.csv
foreach($uneLigne in $monFichier)
    {
        Write-Host $uneLigne
    }

#exercice 1: ecrire dans un fichier
Add-Content -Path C:\Users\Administrateur\Desktop\mdr\test.txt -Value "sofiane"
#exercice 2: 
###voir formulaire###
#exercice 3:
$importdata = Import-Csv C:\Users\Administrateur\Desktop\kaki\user.csv
foreach($data in $importdata)
{
Write-Host $data.id
Write-Host $data.nom
Write-Host $data.prenom
Write-Host $data.login
Write-Host $data.mdp
Write-Host $data.adresse
Write-Host $data.cp
Write-Host $data.ville
Write-Host $data.

}
