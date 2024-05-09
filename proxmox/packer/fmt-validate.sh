#!/bin/bash

echo "Packer HCL Dateien werden formatiert..."
packer fmt rhel9/packer.pkr.hcl

echo "Formatierung abgeschlossen."

echo "Packer HCL Dateien werden validiert..."
packer validate rhel9/packer.pkr.hcl
echo "Validierung abgeschlossen."