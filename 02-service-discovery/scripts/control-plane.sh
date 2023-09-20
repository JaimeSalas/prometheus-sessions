KUBERNETES_VERSION="v1.26.0"
# KUBERNETES_VERSION="v1.27.0-00"
MASTER_IP="10.0.0.10"
NODENAME=$(hostname -s)
POD_CIDR="192.168.0.0/16"

#0 - Creating a Cluster
#Create our kubernetes cluster, specify a pod network range matching that in calico.yaml! 
#Only on the Control Plane Node, download the yaml files for the pod network.
wget https://raw.githubusercontent.com/projectcalico/calico/master/manifests/calico.yaml

#You can now just use kubeadm init to bootstrap the cluster
sudo kubeadm init --kubernetes-version $KUBERNETES_VERSION \
  --apiserver-advertise-address=$MASTER_IP \
  --apiserver-cert-extra-sans=$MASTER_IP \
  --pod-network-cidr=$POD_CIDR \
  --node-name $NODENAME

#Configure our account on the Control Plane Node to have admin access to the API server from a non-privileged account.
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
# sudo --user=vagrant mkdir -p /home/vagrant/.kube
# cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
# chown $(id -u vagrant):$(id -g vagrant) /home/vagrant/.kube/config


#1 - Creating a Pod Network
#Deploy yaml file for your pod network.
kubectl apply -f calico.yaml

sudo --user=vagrant mkdir -p /home/vagrant/.kube
cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
chown $(id -u vagrant):$(id -g vagrant) /home/vagrant/.kube/config

# Save Configs to shared /Vagrant location

# For Vagrant re-runs, check if there is existing configs in the location and delete it for saving new configuration.

config_path="/vagrant/configs"

if [ -d $config_path ]; then
   rm -f $config_path/*
else
   mkdir -p /vagrant/configs
fi

cp /etc/kubernetes/admin.conf /vagrant/configs/config
touch /vagrant/configs/join.sh
chmod +x /vagrant/configs/join.sh

kubeadm token create --print-join-command > /vagrant/configs/join.sh

