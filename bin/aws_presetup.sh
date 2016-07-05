#!/bin/bash

puppet resource package name=awscli provider=pip ensure=present
puppet resource package name=aws-sdk-core provider=gem ensure=present
puppet resource package name=retries provider=gem ensure=present
aws configure

