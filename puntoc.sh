### Desintalamos todo lo que pueda dar conflicto
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

### Configurar tu sistema Ubuntu para poder instalar Docker.
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

### Añadir el repositorio
sudo echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

### Instalar la ultima version de docker
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

### Agregar tu usuario al grupo "docker" y luego relogearse
sudo usermod -aG docker vagrant
sudo su vagrant

### Servicio de docker en enable para que se levante tras el reinicio
sudo systemctl enable --now docker

# Valido el estado del servicio
sudo systemctl status docker

# Estructura dir de docker 
sudo ls -l /var/lib/docker/

# Clonar el repositorio docker
git clone https://github.com/upszot/UTN-FRA_SO_Docker.git

# Frenar el apache si es necesario 
# sudo systemctl stop apache2

# y si vamos a la ip de ma maquina con el ñuerto que desplegue se deberia de ver por el navegador
ip addres show # 192.168.56.9:80

docker stop (id app)

# creamos todas las carpetas y directorios que pide
mkdir appHomeBanking/
cd appHomeBanking/
touch index.html contacto.html
echo "Hola mundo" > index.html
echo "Contacto" > contacto.html
cd ..
touch dockerfile
echo "FROM nginx" > dockerfile
echo "COPY appHomeBanking /usr/share/nginx/html" >> dockerfile

# Logueo con docker
docker login -u ema04

# Costruir el docker
docker build -t ema04/2parcial-ayso:v1.0 .

# Ver las imagenes creadas
sudo docker image list

# Subir mi imagen a docker hub:
docker push ema04/2parcial-ayso:v1.0

docker run -d -p 4321:80 ema04/2parcial-ayso:v1.0
docker container ls
