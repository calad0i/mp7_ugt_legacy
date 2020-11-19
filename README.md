## Simulate

Simulation of gtl_fdl_wrapper with Questa simulator for 6 ugt modules

* This is a description running script `run_simulation_questa.py` for simulation.
* If Questa sim libraries for Vivado do not exist in `$HOME/questasimlibs_xxx`, they will be created for the selected Questa sim and Vivado versions.

### Workflow

Clone git repositories for mp7 and ugt.
```bash
git clone https://gitlab.cern.ch/hbergaue/mp7.git mp7
cd mp7
git checkout mp7fw_v2_4_1_mp7_ugt
git clone https://github.com/cms-l1-globaltrigger/mp7_ugt_legacy.git mp7_ugt_legacy
cd mp7_ugt_legacy
git checkout master
```

Create Python 3 virtual environment.
```bash
python3 -m venv env
. env/bin/activate
pip install -U pip
pip install -r scripts/requirements.txt
```

Run simulation using Questa.
```bash
cd mp7_ugt_legacy
python scripts/run_simulation_questa.py <L1Menu name> --url <url l1menu> --mp7_tag <local mp7 path>
```

Example
```bash
cd ~/github/cms-l1-globaltrigger/mp7_ugt_legacy
python scripts/run_simulation_questa.py L1Menu_Collisions2018_v2_1_0-d5 --url https://raw.githubusercontent.com/herbberg/l1menus/master --mp7_tag ~/gitlab/hbergaue/mp7
```

## Build

Build `mp7_ugt` firmware using IPBB.

* This is a draft description with branches of MP7 and ugt repos.
* A fork of [MP7](https://gitlab.cern.ch/hbergaue/mp7) firmware is available with three branches:
  - branch "mp7fw_v2_4_1_mp7_ugt" created from tag mp7fw_v2_4_1.
  - branch "mp7fw_v2_4_3_mp7_ugt" created from tag mp7fw_v2_4_3.
  - branch "mp7fw_master_mp7_ugt" created from master.
* These branches contain modified MP7 files for mp7_ugt:
  - area_constraints.tcl
  - mp7_brd_decl.vhd
  - mp7xe_690.vhd
* One of these branches can be used for build (see below).

* The ugt repo is a fork of [svn2git ugt](https://gitlab.cern.ch/cms-cactus/svn2git/firmware/ugt) repo.
Following modifications are done in the branch:
  - added [ugt_strategy.tcl](https://gitlab.cern.ch/hbergaue/ugt/blob/master/mp7_ugt/firmware/ucf/ugt_strategy.tcl) for ugt specific strategy and inserted it
into [top.dep](https://gitlab.cern.ch/hbergaue/ugt/blob/master/mp7_ugt/firmware/cfg/top.dep).
  - added [l1menu_files.tcl](https://gitlab.cern.ch/hbergaue/ugt/blob/master/mp7_ugt/firmware/cfg/l1menu_files.tcl) for adding L1Menu VHDL files and inserted it
into [top.dep](https://gitlab.cern.ch/hbergaue/ugt/blob/master/mp7_ugt/firmware/cfg/top.dep).
  - modified [uGT_algo.dep](https://gitlab.cern.ch/hbergaue/ugt/blob/master/mp7_ugt/firmware/cfg/uGT_algo.dep): removed "doubled" commands (these commnads are in MP7 dep files).
  - added script [runIpbbSynth.py](https://gitlab.cern.ch/hbergaue/ugt/blob/master/mp7_ugt/scripts/runIpbbSynth.py) for IPBB synthesis (all 6 mp7_ugt modules) with the possibility of simulation.
  - added script [checkIpbbSynth.py](https://gitlab.cern.ch/hbergaue/ugt/blob/master/mp7_ugt/scripts/checkIpbbSynth.py) for checking IPBB synthesis results.
  - added script [fwpackerIpbb.py](https://gitlab.cern.ch/hbergaue/ugt/blob/master/mp7_ugt/scripts/fwpackerIpbb.py) for packing firware files in a tar file.

### Setup using script

Run kerberos for outside of CERN network.
```bash
kinit <username>@CERN.CH
```

Make local clone of ugt repositiory.
```bash
git clone https://github.com/cms-l1-globaltrigger/mp7_ugt_legacy.git <local path>/mp7_ugt_legacy
cd <local path>/mp7_ugt_legacy
```

Run synthesis script (for all 6 modules).

```bash
python mp7_ugt/scripts/runIpbbSynth.py <L1Menu name> --mp7url <URL MP7 git repo> --mp7tag <MP7 tag> -p <work dir> --build <build-version> --ugturl <URL ugt git repo> -u <ugt tag in repo>
```

**Note:** inspect default values for arguments using
```bash
python mp7_ugt/scripts/runIpbbSynth.py -h
```

Example
```bash
python mp7_ugt/scripts/runIpbbSynth.py L1Menu_Collisions2018_v2_1_0-d2 --mp7url https://:@gitlab.cern.ch:8443/hbergaue/mp7.git --mp7tag mp7fw_v2_4_1 -p ~/work_ipbb --build 0x1100 --ugturl https://github.com/cms-l1-globaltrigger/mp7_ugt_legacy --ugt v1.10.3
```

Run synthesis script (for all 6 modules) with simulation (Questasim)
```bash
git clone https://gitlab.cern.ch/hbergaue/mp7.git <local MP7 repo path>
git clone https://github.com/cms-l1-globaltrigger/mp7_ugt_legacy.git <local path>/mp7_ugt_legacy
cd <local path>/mp7_ugt_legacy
python scripts/runIpbbSynth.py <L1Menu name> --mp7url <URL MP7 git repo> --mp7tag <MP7 tag> -p <work dir> --build <build version> --ugturl <URL ugt git repo> -u <ugt tag in repo> --sim --simmp7path <local MP7 repo path>
```

Example
```bash
python scripts/runIpbbSynth.py L1Menu_Collisions2018_v2_1_0-d2 \
  --mp7url https://:@gitlab.cern.ch:8443/hbergaue/mp7.git \
  --mp7tag mp7fw_v2_4_1 \
  -p ~/work_ipbb_test \
  --build 0x1100 \
  --ugturl https://github.com/cms-l1-globaltrigger/mp7_ugt_legacy \
  --ugt v1.10.3 \
  --sim \
  --simmp7path ~/gitlab/hbergaue/mp7
```

### Setup (commands for one module)

Run kerberos for outside of CERN network
```bash
kinit <username>@CERN.CH
```

Download and install IPBB
```bash
curl -L https://github.com/ipbus/ipbb/archive/v0.5.2.tar.gz | tar xvz
source ipbb-0.5.2/env.sh
```

Create a local working area
```bash
ipbb init mp7_ugt/<mp7fw version>/<menu version>/<build version>/module_<module number>
cd mp7_ugt/<mp7fw version>/<menu version>/<build version>/module_<module number>
ipbb add git https://github.com/ipbus/ipbus-firmware.git -b master
ipbb add git https://:@gitlab.cern.ch:8443/hbergaue/mp7.git -b mp7fw_v2_4_1_mp7_ugt
ipbb add git https://github.com/cms-l1-globaltrigger/mp7_ugt_legacy -b <master or branch name or tag name>
```

Copy VHDL producer output and patched files to mp7_ugt (`gtl_module.vhd`, `gtl_pkg.vhd`, `algo_mapping_rop.vhd` and `gt_mp7_top_pkg.vhd`)

Source Vivado

Create project
```bash
ipbb proj create vivado module_<module number> mp7:../mp7_ugt_legacy
cd proj/module_<module number>
ipbb vivado make-project
```

Run implementation, synthesis
```bash
ipbb vivado synth
ipbb vivado impl
```

Generate a bitfile
```bash
ipbb vivado package
deactivate
```
