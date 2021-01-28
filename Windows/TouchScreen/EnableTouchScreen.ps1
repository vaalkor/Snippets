$id = (Get-PnpDevice -FriendlyName "HID-Compliant Touch Screen").InstanceID
$props = Get-PnpDeviceProperty -InstanceId $id
Enable-PnpDevice -InstanceId $id -Confirm:$false