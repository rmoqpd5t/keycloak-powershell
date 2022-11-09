$InputFilename = "master-realm.json"
$OutputFilename = "master-realm.csv"
$json = ConvertFrom-JSON (Get-Content $InputFilename -Raw)
$MASTER_ARRAY_LIST = [System.Collections.ArrayList]@()
$myidplist = [System.Collections.ArrayList]@()

for ($j = 0; $j -lt $json.identityProviderMappers.count; $j++) {
    $json.identityProviderMappers[$j] | ForEach-Object {
        $CURRENT_RECORD_DETAILS = New-Object PSObject -Property @{'id' = $($json.identityProviderMappers[$j].id); 'name' = $($json.identityProviderMappers[$j].name); 'identityProviderAlias' = $($json.identityProviderMappers[$j].identityProviderAlias); 'syncMode' = $($json.identityProviderMappers[$j].config.syncMode); 'user.attribute' = $($json.identityProviderMappers[$j].config.'user.attribute') ; 'attribute.name' = $($json.identityProviderMappers[$j].config.'attribute.name') ; 'attribute.value' = $($json.identityProviderMappers[$j].config.'attribute.value') ;}
        $MASTER_ARRAY_LIST.Add( $CURRENT_RECORD_DETAILS ) > $null
    }
}  
$MASTER_ARRAY_LIST | Export-Csv -Path $OutputFilename
