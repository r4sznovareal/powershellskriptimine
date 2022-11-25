$Eesnimi = Read-Host -Prompt "Palun sisestage enda eesnimi"
$Perenimi = Read-Host -Prompt "Palun sisestage enda perenimi"

$Kasutajanimi = $Eesnimi.ToLower() + "." + $Perenimi.ToLower()

#kasutaja eemaldamine
if (Get-LocalUser | Where-Object Name -eq $Kasutajanimi) { # otsitakse üles antud eesnime ja perenime järgi kasutajanimi.
    Remove-LocalUser -Name $Kasutajanimi #kui see on olemas, kustutakse kasutaja.
    Write-Output "Kasutaja on kustutatud."
} else {
    Write-Output "$Kasutajanimi nimelist kasutajat ei ole olemas." #vastasel juhul antakse veateade, et sellist kasutajat ei ole olemas.
}