# crear 3 particiones principales
sudo fdisk /dev/sdc
n new
p partition
enter 
enter 
+1M
 
# crear 1 partición extendida
n new
e extended
enter
+3G
 
# creación 2 particiones logicas dentro de extendida
n new 
enter 
+1.5g # la segunda con +1.3g

# partición 1 con swap
t
1
82 # elige fs swap
w guardar 

# partición 1 destinarla como swap
sudo mkswap /dev/sdc1

# activar la memoria swap con el comando
sudo swapon /dev/sdc1
free -h

# partición 2 con lvm
sudo fdisk /dev/sdc
t
2
8E # lvm

# crear un volumen fisico en cada particion
sudo pvcreate /dev/sdc2 /dev/sdc2  /dev/sdc5 /dev/sdc6

# crear un grupo de volumenes
sudo vgcreate vgAdmin /dev/sdc2 /dev/sdc3
sudo vgcreate vgDevelopers /dev/sdc5 /dev/sdc6

sudo pvs
sudo vgs 

# crear los volumenes logicos
sudo lvcreate -L 1.9G vgAdmin -n lvAdmin
sudo lvcreate -L 1G vgDevelopers -n lvDevs
sudo lvcreate -L 1G vgDevelopers -n lvTesters
sudo lvcreate -L 1.8G vgDevelopers -n lvDevops

sudo lvs

# formatear los volumenes logicos
sudo fdisk - l # muestra el mapeo

sudo mkfs.ext4 /dev/mapper/vgAdmin-lvAdmin
sudo mkfs.ext4 /dev/mapper/vgDevelopers-lvDevs
sudo mkfs.ext4 /dev/mapper/vgDevelopers-lvTesters
sudo mkfs.ext4 /dev/mapper/vgDevelopers-lvDevops

# montar los volumenes logicos
sudo mkdir /mnt/lvAdmin
sudo mkdir /mnt/lvDevs
sudo mkdir /mnt/lvTesters
sudo mkdir /mnt/lvDevops

sudo mount /dev/mapper/vgAdmin-lvAdmin /mnt/lvAdmin
sudo mount /dev/mapper/vgDevelopers-lvDevs /mnt/lvDevs
sudo mount /dev/mapper/vgDevelopers-lvTesters /mnt/lvTesters
sudo mount /dev/mapper/vgDevelopers-lvDevops /mnt/lvDevops

df -h # verificar los montajes
