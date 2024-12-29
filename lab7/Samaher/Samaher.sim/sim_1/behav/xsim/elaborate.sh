#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2019.1 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Sun Dec 29 15:17:31 +03 2024
# SW Build 2552052 on Fri May 24 14:47:09 MDT 2019
#
# Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
echo "xelab -wto 48448432479b430a920f81b596e16c40 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot rv32i_top_tb_behav xil_defaultlib.rv32i_top_tb xil_defaultlib.glbl -log elaborate.log"
xelab -wto 48448432479b430a920f81b596e16c40 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot rv32i_top_tb_behav xil_defaultlib.rv32i_top_tb xil_defaultlib.glbl -log elaborate.log

