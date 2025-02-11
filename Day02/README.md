Notes:
1. Terraform says use provisioner as a last resort, if can don't use provisioner
2. Use Ansible to manage servers
3. yaml files only can have spaces, no tabs /t
4. for task, under state, if u want it put state: present, if dont want it put state: absent
5. under apt: name: put the version as part of the name
6. 2 shell type - bash or zsh
7. command:
    argv:
        - /bin/sh
        - -c
        - "ls" -> will run this in a shell. 
    
    Equivalent for:
    shell:
        cmd: "ls -l"
        chdir: /etc
8. systemd only for ubuntu, redhat is yum
    
cd /var/www/html, copy the files: 
