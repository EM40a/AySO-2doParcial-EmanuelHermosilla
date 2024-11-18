### en el nodo
sudo apt update
sudo apt install ansible

sudo apt list --installed |grep ansible

ll .ssh/

ssh-keygen

# copiar la clave publica al servidor
cat .ssh/id_rsa.pub

# pegarla en el host
echo "clave publica" >> .ssh/authorized_keys
cat .ssh/authorized_keys

git clone https://github.com/upszot/utN-FRA_SO_ansible.git
cd utN-FRA_SO_ansible/ejemplo_02/
nano inventory

# [desarrollo]
# 192.168.56.9

# [produccion]
# 192.168.56.8

nano playbook.yml
ansible-playbook -i inventory playbook.yml

# conectarme desde el nodo al host
ssh vagrant@192.168.56.9

apt list --installed |grep apache
exit # vuelvo al nodo
