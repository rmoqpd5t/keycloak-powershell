$InputFilename = "master-realm.json"
$OutputFilename = "master-realm.csv"
$json = ConvertFrom-JSON (Get-Content $InputFilename -Raw)
$MASTER_ARRAY_LIST = [System.Collections.ArrayList]@()
$myclientlist = [System.Collections.ArrayList]@()
for ( $i = 0; $i -lt $json.clients.count; $i++ ) { 
    $myclientlist += $json.clients.clientID[$i]
    $myprotcolMapperlist = @()
    for ($j = 0; $j -lt $json.clients[$i].protocolMappers.count; $j++) {
        $json.clients[$i].protocolMappers[$j] | ForEach-Object {
            $CURRENT_RECORD_DETAILS = New-Object PSObject -Property @{'client' = $($json.clients[$i].clientID); 'id' = $($json.clients[$i].protocolMappers[$j].'id'); 'name' = $($json.clients[$i].protocolMappers[$j].'name'); 'attribute.name' = $($json.clients[$i].protocolMappers[$j].config.'attribute.name'); 'user.attribute' = $($json.clients[$i].protocolMappers[$j].config.'user.attribute'); 'attribute.value' = $($json.clients[$i].protocolMappers[$j].config.'attribute.value'); }
            $MASTER_ARRAY_LIST.Add( $CURRENT_RECORD_DETAILS ) > $null
        }
    }  
}
$MASTER_ARRAY_LIST | Export-Csv -Path $OutputFilename
