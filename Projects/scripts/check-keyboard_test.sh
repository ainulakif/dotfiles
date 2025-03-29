
#!/bin/sh

ID=$(xinput list --short | grep "AT Translated Set 2 keyboard" | awk -F'id=' '{print $2}' | awk '{print $1}')&>/dev/null

echo $ID
