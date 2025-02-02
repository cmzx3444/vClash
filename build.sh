#!/bin/bash
########################################################################
# File Name: build.sh
# Author: zioer
# mail: next4nextjob@gmail.com
# Created Time: 2022年01月02日 星期日 23时06分29秒
########################################################################

usage() {
    cat <<END
 Usage:
    `basename $0` pack <version>
    `basename $0` yaml

 Params:
    version : new version number , v2.2.4
END
}
# 生成最新版本Clash安装包 #
if [ "$1" = "" ] ; then
    usage
    exit
fi

generate_gfwlist() {
    # 生成gfw.yaml #
    outdir="./clash/clash/ruleset/"
    curl -s https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/gfw.txt > ${outdir}/gfw.tmp
    yq e '.payload[]' ${outdir}/gfw.tmp | awk -F'.' 'BEGIN{
        printf("payload:\n");
    }{
        idx=$(NF-1)"."$(NF);
        a[idx]++;
    }END{
        for(i in a)
            printf("  - '\''+.%s'\''\n", i);
    }' > ${outdir}/rule_diy_gfw.yaml
    yq e -iP ${outdir}/rule_diy_gfw.yaml
    rm -f ${outdir}/gfw.tmp
    echo "rule_diy_gfw.yaml 生成完毕."
}

generate_direct() {
    # 生成direct.yaml #
    outdir="./clash/clash/ruleset/"
    curl -s https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/direct.txt > ${outdir}/direct.tmp
    yq e '.payload[]' ${outdir}/direct.tmp | awk -F'.' 'BEGIN{
        printf("payload:\n");
    }$NF~/org|com|cn|net|edu|gov/ && $(NF-1)!~/[a-z][0-9]/ && $(NF-1)~/qiniu|baidu|cloudflare|upyun|cachemoment|163|265|360|tecent|qq|cdn|verycloud|ali/ {
        idx=$(NF-1)"."$(NF);
        a[idx]++;
    }END{
        for(i in a)
            printf("  - '\''+.%s'\''\n", i);
    }' > ${outdir}/rule_diy_direct.yaml
    yq e -iP ${outdir}/rule_diy_direct.yaml
    rm -f ${outdir}/direct.tmp
    echo "rule_diy_direct.yaml 生成完毕."
}

generate_package() {
    # 生成release安装包
    echo "正在生成 release 安装包 ..."
    outdir="./release/"
    new_version="$1"
    sed -i "s/vClash:.*/vClash:$new_version/" clash/clash/version
    echo -n "arm384" > clash/.valid
    tar zcf ./release/clash_384.tar.gz clash/
    echo -n "hnd|arm384|arm386|p1axhnd.675x" > clash/.valid
    tar zcf ./release/clash.tar.gz clash/
}


case "$1" in
    pack)
        generate_package $2
        ;;
    yaml)
        generate_gfwlist
        generate_direct
        ;;
    *)
        usage
        ;;
esac
