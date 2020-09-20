#!/bin/bash

          cd friendlywrt-rk3328
          . ../remove_unused_config.sh
          cat configs/config_rk3328 | grep "TARGET" >> ../base_rk3328.seed
          cat ../minimal_config.seed >> ../base_rk3328.seed
          cat ../custom/custom_config.seed >> ../base_rk3328.seed
          cat ../base_rk3328.seed > configs/config_rk3328
          cd friendlywrt
          git remote add upstream https://github.com/coolsnowwolf/openwrt && git fetch upstream
          git checkout upstream/lede-17.01 -b tmp
          git rm README.md
          git commit -m 'reset'
          git checkout master-v19.07.1
          git rebase adc1a9a3676b8d7be1b48b5aed185a94d8e42728^ --onto tmp -X theirs
          rm -f target/linux/rockchip-rk3328/patches-4.14/0001-net-thunderx-workaround-BGX-TX-Underflow-issue.patch target/linux/generic/hack-4.14/999-net-patch-linux-kernel-to-support-shortcut-fe.patch
          git checkout upstream/lede-17.01 -- feeds.conf.default && sed -i -E 's/#(src-git.+)(helloworld.+)/\1\2/' feeds.conf.default
          cd package/lean/
          . ../../../../3_prepare_packages.sh
          cd ../../
          git apply ../../enable_autocore.diff
          sed -i 's/@LINUX_5_4//' package/lean/luci-app-flowoffload/Makefile
          . ../../5_mods.sh
          mv ../../scripts/check_wan4.sh package/base-files/files/usr/bin && sed -i '/exit/i\/bin/sh /usr/bin/check_wan4.sh &' package/base-files/files/etc/rc.local
          mv ../../scripts/autoupdate.sh package/base-files/files/root/au.sh && chmod +x package/base-files/files/root/au.sh

exit 0
