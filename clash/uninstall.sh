#! /bin/sh

#########################################################
# Clash script for AM380 merlin firmware
# Writen by Awkee (next4nextjob(at)gmail.com) 
# Website: https://vlike.work
#########################################################

KSHOME="/koolshare"
source ${KSHOME}/scripts/base.sh

LOGGER() {
    # Magic number for Log 9977
    logger -s -t "$(date +%Y年%m月%d日%H:%M:%S):clash" "$@"
}

app_name="clash"

# 清理文件目录
bin_list="${app_name} yq uri_decoder"

# 清理旧文件，升级情况需要
remove_files() {
    LOGGER 清理旧文件
    LOGGER "执行命令：rm -rf /koolshare/${app_name}"
    rm -rf /koolshare/${app_name}

    LOGGER "执行命令： rm -rf /koolshare/webs/Module_${app_name}.asp"
    rm -rf /koolshare/webs/Module_${app_name}.asp
    for fn in ${bin_list}
    do
        LOGGER "执行命令： rm -f /koolshare/bin/${fn}"
        rm -f /koolshare/bin/${fn}
    done
    LOGGER "执行命令： rm -f /koolshare/res/icon-${app_name}.png"
    rm -rf /koolshare/res/icon-${app_name}.png
    
    LOGGER "执行命令： rm -rf /koolshare/res/${app_name}_*"
    rm -rf /koolshare/res/${app_name}_*
    LOGGER "执行命令： rm -f /koolshare/init.d/S??${app_name}.sh"
    rm -rf /koolshare/init.d/S??${app_name}.sh
}


remove_env() {
    # 清理环境变量, 相当于清理数据库，避免无意义数据遗留在数据库中
    LOGGER "清理环境变量信息:"
    dbus remove softcenter_module_${app_name}_home_url
    dbus remove softcenter_module_${app_name}_install
    dbus remove softcenter_module_${app_name}_title
    dbus remove softcenter_module_${app_name}_version

    dbus remove ${app_name}_enable
    dbus remove ${app_name}_action
    dbus remove ${app_name}_trans
    dbus remove ${app_name}_version
    dbus remove ${app_name}_provider_file_old
    dbus remove ${app_name}_provider_file
    dbus remove ${app_name}_group_type
    dbus remove ${app_name}_select_type
    dbus remove ${app_name}_provider_url
    dbus remove ${app_name}_node_list
    dbus remove ${app_name}_name_list
    dbus remove ${app_name}_delete_name
    dbus remove ${app_name}_gfwlist_mode
    dbus remove ${app_name}_cfddns_enable
    # 配置清理
    dbus remove ${app_name}_cfddns_email
    dbus remove ${app_name}_cfddns_apikey
    dbus remove ${app_name}_cfddns_domain
    dbus remove ${app_name}_cfddns_ttl
    dbus remove ${app_name}_cfddns_ip
    dbus remove ${app_name}_cfddns_zone
    dbus remove ${app_name}_cfddns_zid
    dbus remove ${app_name}_cfddns_recid
}

LOGGER "开始卸载插件啦！"

sh /koolshare/scripts/${app_name}_control.sh stop

remove_files
remove_env
LOGGER "卸载完成啦！一切都归于尘土，哦不！是垃圾站！"

LOGGER "执行命令：rm -rf /koolshare/scripts/${app_name}_*"
rm -rf /koolshare/scripts/${app_name}_*

