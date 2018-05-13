#!/usr/bin/env bash

sudo systemctl enable cloud-init
sudo systemctl enable cloud-init-local
sudo systemctl enable cloud-config
sudo systemctl enable cloud-final

sudo systemctl daemon-reload

sudo systemctl start cloud-init
sudo systemctl start cloud-init-local
sudo systemctl start cloud-config
sudo systemctl start cloud-final


