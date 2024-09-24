

OBS:
user: vagrant
password: vagrant

Explicação:
config.vm.box: Define a imagem base (neste caso, ubuntu/focal64 para o Ubuntu 20.04).

config.vm.network "public_network", bridge:: Configura a placa de rede no modo bridge, permitindo que a VM obtenha um IP diretamente da rede local. 
Você pode precisar alterar o nome da interface para a correta do seu host (no exemplo, está configurado para en0: Wi-Fi (AirPort) no macOS).

vb.memory e vb.cpus: Definem a memória RAM e a quantidade de CPUs disponíveis para a VM.

config.vm.synced_folder: Este comando sincroniza uma pasta do seu sistema host com a máquina virtual.
O primeiro argumento ("./pasta_local") é o caminho da pasta no host, que pode ser relativo ou absoluto.
O segundo argumento ("/vagrant/pasta_remota") é o caminho da pasta dentro da VM.
create: true: Se a pasta não existir na VM, ela será criada.

Passos para usar:
Salve este código em um arquivo chamado Vagrantfile.
No terminal, navegue até a pasta onde o Vagrantfile foi salvo.
Execute o comando vagrant up para iniciar a VM.
Atualize o Vagrantfile com a configuração de sincronização.
No terminal, navegue até a pasta onde está o Vagrantfile e execute o comando vagrant up (ou vagrant reload se a VM já estiver em execução) para que a VM reconheça a sincronização.
A pasta especificada no host estará disponível na VM no caminho especificado (neste caso, /vagrant/pasta_remota).

Caso precise de mais personalizações, como a instalação de pacotes adicionais ou compartilhamento de pastas, pode-se expandir esse arquivo.