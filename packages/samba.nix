{ config, pkgs, ... }:
    {
    services.samba = {
    enable = true;

    openFirewall = true;
    settings = {
        global = {
        "workgroup" = "WORKGROUP";
        "server string" = "smbnix";
        "netbios name" = "smbnix";
        "security" = "user";
        #"use sendfile" = "yes";
        #"max protocol" = "smb2";
        # note: localhost is the ipv6 localhost ::1
        "hosts allow" = "192.168.1. 127.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0";
        "guest account" = "nobody";
        "map to guest" = "bad user";
        };
        "HD" = {
        "path" = "/HD/";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "gwhittey";
        "force group" = "gwhittey";
        };
        "Hone" = {
        "path" = "/home/gwhittey";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "gwhittey";
        "force group" = "gwhittey";
        };
    };
    };

    services.samba-wsdd = {
    enable = true;
    openFirewall = true;
    };
}