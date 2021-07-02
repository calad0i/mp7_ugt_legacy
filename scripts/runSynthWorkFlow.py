#!/usr/bin/env python2
# -*- coding: utf-8 -*-

import argparse
import configparser
import logging
import os
import subprocess
import sys
import urllib.request
import urllib.parse
import urllib.error

import toolbox as tb
from time import sleep

EXIT_SUCCESS = 0
EXIT_FAILURE = 1

DefaultSynthDir = 'work_synth/production'
DefaultUgtTag = 'master'


def read_file(filename):
    """Returns contents of a file."""
    with open(filename, 'r') as fp:
        return fp.read()

def run_command(*args):
    command = ' '.join(args)
    logging.info(">$ %s", command)
    os.system(command)

def parse_args():
    """Parse command line arguments."""
    parser = argparse.ArgumentParser()
    parser.add_argument('menuname', type=tb.xmlname_t, help="L1Menu name (eg. 'L1Menu_Collisions2020_v0_1_6')")
    parser.add_argument('--user', required=True, help="synthesis server user name [required]")
    parser.add_argument('--github_user', required=True, help="git hub user name [required]")
    parser.add_argument('--temp_dir', metavar='<path>', required=True, help="temporarly workflow dir name [required]")
    parser.add_argument('--xml_path', metavar='<path>', required=True, help="absolute path to XML file [required]")
    parser.add_argument('--tv_path', metavar='<path>', required=True, help="absolute path to test vector file [required]")
    parser.add_argument('--dist', required=True, help="distribution number for VHDL Producer [required]")
    parser.add_argument('--ugt', metavar='<path>', default=DefaultUgtTag, help="ugt firmware repo: tag or branch name (default is '{}')".format(DefaultUgtTag))
    parser.add_argument('--synth_dir', metavar='<path>', default=DefaultSynthDir, help="relative path to local dir for synthesis results (default is '{}')".format(DefaultSynthDir))
    parser.add_argument('--build', type=tb.build_str_t, required=True, metavar='<version>', help="menu build version (eg. 0x1001) [required]")
    return parser.parse_args()

def main():
    """Main routine."""

    # Parse command line arguments.
    args = parse_args()

    menuname_dist = "{}-d{}".format(args.menuname, args.dist)
    home_dir = "/home/{}".format(args.user)
    menu_dir = 'cms-l1-menu'
    year_dir = '2021'
    menu_local = "{}/{}".format(menu_dir, year_dir)
    menu_repo = "{}/{}/{}/{}".format(args.github_user, menu_dir, menuname_dist, year_dir)
    menu_url = "https://raw.githubusercontent.com/{}".format(menu_repo)
    ugt_local_dir = 'mp7_ugt_legacy'

    commit_message = "'added new menu {}'".format(menuname_dist)

    # Setup console logging
    logging.basicConfig(format='%(levelname)s: %(message)s', level=logging.INFO)

    local_menu_path = "{}/{}/{}/{}".format(home_dir, args.temp_dir, menu_local, menuname_dist)
    print(local_menu_path)
    if os.path.exists(local_menu_path):
        raise RuntimeError('%s exists - remove it and execute script once more' % local_menu_path)

    if not os.path.exists(args.xml_path):
        raise RuntimeError('%s does not exists' % args.xml_path)

    if not os.path.exists(args.tv_path):
        raise RuntimeError('%s does not exists' % args.tv_path)

    synth_dir_build_path = "{}/{}".format(args.synth_dir, args.build)
    if os.path.exists(synth_dir_build_path):
        raise RuntimeError('%s exists - remove build and execute script once more' % synth_dir_build_path)

    #logging.info("===========================================================================")
    #logging.info("check '%s' with TME", args.xml_path)
    #command = 'bash -c "cd; ./tm-editor {args.xml_path}"'.format(**locals())
    #run_command(command)

    logging.info("===========================================================================")
    logging.info("clone menu repo '%s' to '%s'", menuname_dist, args.temp_dir)
    command = 'bash -c "git clone https://github.com/{args.github_user}/cms-l1-menu.git {home_dir}/{args.temp_dir}/cms-l1-menu; "'.format(**locals())
    run_command(command)

    logging.info("===========================================================================")
    logging.info("check branch '%s' exists", menuname_dist)
    command = 'bash -c "cd {home_dir}/{args.temp_dir}/cms-l1-menu; git checkout {menuname_dist} &> git_branch_exists.txt"'.format(**locals())
    run_command(command)

    file_name = "{}/{}/{}/git_branch_exists.txt".format(home_dir, args.temp_dir, menu_dir)
    words = read_file(file_name).split(' ')
    if words[0] == 'error:':
        logging.info("===========================================================================")
        logging.info("create new branch '%s'", menuname_dist)
        command = 'bash -c "cd {home_dir}/{args.temp_dir}/cms-l1-menu; git checkout L1Menu_Collisions2020_v0_1_5-d3; git checkout -b {menuname_dist}"'.format(**locals())
        run_command(command)
    else:
        logging.info("===========================================================================")
        logging.info("branch '%s' exists", menuname_dist)

    logging.info("===========================================================================")
    logging.info("clone repo 'mp7' to %s (for simulation)", args.temp_dir)
    command = 'bash -c "git clone https://gitlab.cern.ch/hbergaue/mp7.git {home_dir}/{args.temp_dir}/mp7"'.format(**locals())
    run_command(command)

    logging.info("===========================================================================")
    logging.info("checkout branch mp7fw_v2_4_1_mp7_ugt of repo mp7 to %s (for simulation)", args.temp_dir)
    command = 'bash -c "cd {home_dir}/{args.temp_dir}/mp7; git checkout mp7fw_v2_4_1_mp7_ugt"'.format(**locals())
    run_command(command)

    logging.info("===========================================================================")
    logging.info("install tm-vhdlproducer in %s", args.temp_dir)
    command = 'bash -c "cd {home_dir}/{args.temp_dir}; pip install -U pip; pip install git+https://github.com/herbberg/tm-vhdlproducer.git@master"'.format(**locals())
    run_command(command)

    if os.path.exists(synth_dir_build_path):
        raise RuntimeError('%s exists - remove build %s and execute script once more' % synth_dir_build_path, synth_dir_build_path)

    logging.info("===========================================================================")
    logging.info("run VHDL Producer")
    command = 'bash -c "tm-vhdlproducer {args.xml_path} --modules 6 --dist {args.dist} --sorting desc --output {home_dir}/{args.temp_dir}/{menu_local}"'.format(**locals())
    run_command(command)

    logging.info("===========================================================================")
    logging.info("copy test vector file to created menu %s", local_menu_path)
    command = 'bash -c "scp {args.tv_path} {local_menu_path}/testvectors/TestVector_{args.menuname}.txt"'.format(**locals())
    run_command(command)

    logging.info("===========================================================================")
    logging.info("commit generated VHDL code of menu %s", menuname_dist)
    command = 'bash -c "cd {home_dir}/{args.temp_dir}/{menu_local}; git add {menuname_dist}; git pull; git commit -m {commit_message}; git push --set-upstream origin {menuname_dist}"'.format(**locals())
    run_command(command)

    sleep(2.0)

    logging.info("===========================================================================")
    logging.info("run simulation")
    subprocess.check_call(['python3', os.path.join(home_dir, args.temp_dir, ugt_local_dir, 'scripts', 'run_simulation_questa.py'), menuname_dist, '--url', os.path.join(menu_url), '--mp7_tag', os.path.join(home_dir, args.temp_dir, 'mp7')])

    logging.info("===========================================================================")
    logging.info("run synthesis (takes about 4 hours)")
    subprocess.check_call(['python3', os.path.join(home_dir, args.temp_dir, ugt_local_dir, 'scripts', 'runIpbbSynth.py'), menuname_dist, '--menuurl', os.path.join(menu_url), '--ugturl', 'https://github.com/cms-l1-globaltrigger/mp7_ugt_legacy', '--ugt', args.ugt, '--build', args.build, '-p', args.synth_dir])

    write_bitstream_path = "{}/{}/scripts/vivado_write_bitstream.tcl".format(home_dir, ugt_local_dir)
    build_path = "{}/{}/{}/mp7_ugt_legacy/{}/mp7fw_v3_0_0/vivado_2019.2".format(args.synth_dir, args.build, menuname_dist, args.ugt)
    build_cfg = "{}/build_{}.cfg".format(build_path, args.build)
    check_path = "{}/{}/scripts/checkIpbbSynth.py".format(home_dir, ugt_local_dir)
    packer_path = "{}/{}/scripts/fwpackerIpbb.py".format(home_dir, ugt_local_dir)

    print("===========================================================================")
    print("check, whether syntheses stll running with:")
    print("$ screen -r")
    print(" ")
    print("after all syntheses have finished, check results with:")
    print("$ python3", check_path, build_cfg)
    print(" ")
    print("if timing errors (and bit files is not generated) occur, execute the following command for every module with errors:")
    print("$ vivado -mode batch -source", write_bitstream_path," -tclargs", build_path," <module number (e.g.: 0)>")
    print(" ")
    print("after successfully created bit files, execute the following command to create tar file for HW:")
    print("$ python3", packer_path, build_cfg)
    print("===========================================================================")

    logging.info("done.")

if __name__ == '__main__':
    try:
        main()
    except RuntimeError as message:
        logging.error(message)
        sys.exit(EXIT_FAILURE)
    sys.exit(EXIT_SUCCESS)