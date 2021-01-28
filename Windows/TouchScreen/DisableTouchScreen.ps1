$id = (Get-PnpDevice -FriendlyName "HID-Compliant Touch Screen").InstanceID
$props = Get-PnpDeviceProperty -InstanceId $id
Disable-PnpDevice -InstanceId $id -Confirm:$false