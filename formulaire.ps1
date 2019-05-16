$cheminFichier = "C:\Users\Administrateur\Desktop\kaki\user.csv"

Write-Host "entrer votre ID : "
$ID = Read-Host
Write-Host "entrer votre nom : "
$nom = Read-Host
Write-Host "entrer votre prenom : "
$prenom = Read-Host
Write-Host "entrer votre login : " 
$login = Read-Host 
Write-Host "entrer votre mdp : "
$mdp = Read-Host
Write-Host "entrer votre adresse : "
$adresse = Read-Host
Write-Host "entrer votre code postal : "
$cp = Read-Host
Write-Host "entrer votre ville : "
$ville = Read-Host
Write-Host "entrer votre date embauche : "
$dateEmbauche = Read-Host

Add-Content -path $cheminFichier "$ID, $nom, $prenom, $login, $mdp, $adresse, $cp, $ville, $dateEmbauche"