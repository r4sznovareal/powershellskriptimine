$Eesnimi = Read-Host -Prompt "Palun sisestage enda eesnimi"
$Perenimi = Read-Host -Prompt "Palun sisestage enda perenimi"

$Kasutajanimi = $Eesnimi.ToLower() + "." + $Perenimi.ToLower()
$Taisnimi = $Eesnimi + " " + $Perenimi
$KontoKirjeldus = "Lokaalne kasutaja"
$Parool = ConvertTo-SecureString "Parool1!" -AsPlainText -Force

# sellega kontrollib, kas sellise eesnime ja perenimega kasutaja eksisteerib (Measure-Object vaatab, kas selline kasutaja juba eksisteerib või mitte.)
$usercheck = Get-LocalUser | Where-Object Name -eq $Kasutajanimi | Measure-Object

# kui sellist kasutajat ei ole ehk on tühi (0), loodakse kasutaja antud eesnime ja perenime järgi.
if ($usercheck.Count -eq 0) {
    New-LocalUser $Kasutajanimi -password $Parool -FullName $Taisnimi -Description $KontoKirjeldus
    echo "Kasutaja loomine õnnestus!"
} else {
    echo "Kasutaja juba eksisteerib."
}