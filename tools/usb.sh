echo -n "0000:00:1d.1" | tee /sys/bus/pci/drivers/ehci_hcd/unbind
echo -n "0000:00:1d.1" | tee /sys/bus/pci/drivers/ehci_hcd/bind

