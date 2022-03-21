# ------------------------------------
# Docker alias and function
# ------------------------------------

# Get latest container ID
alias dl="docker ps -l -q"

# Get container process
alias dps="docker ps"
# Get process included stop container
alias dpsa="docker ps -a"
# Get process with format
alias dpsf='docker ps --format "table {{.ID}} {{.Names}}\t{{.Image}}\t{{.Status}}"'
# Get process use format and make more simple
alias dpsaf='docker ps -a --format "table {{.ID}} {{.Names}}\t{{.Image}}\t{{.Status}}"'

# Get images
alias di='docker images --format "table {{.Repository}}:{{.Tag}}\t{{.ID}}\t{{.CreatedSince}}\t{{.Size}}"'

# Get container
alias dc='docker container'

# Get network
alias dnet='docker network'

# Get container IP
alias dip="docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"

# Get all container ip with running
dips() {
    for container_name in $(docker ps --format "{{.Names}}"); do
        container_ip=$(dip $container_name)
        echo "$container_ip\t$container_name"
    done
}

# Run deamonized container, e.g., $dkd base /bin/echo hello
alias dkd="docker run -d -P"

# Run interactive container, e.g., $dki base /bin/bash
alias dki="docker run -i -t -P"

# Execute interactive container, e.g., $dex base /bin/bash
alias dex="docker exec -i -t"

# Execute to recerent interactive container, e.g., $dexr /bin/bash
alias dexr="docker exec -i -t $(docker ps -l -q)"

# Alias for docker logs
alias dlogs='docker logs'
alias dlogsf='docker logs -f'

# Alias for docker-compose command
alias dcp='docker-compose'

# Stop all containers
dstop() { docker stop $(docker ps -a -q); }

# Remove all containers
drm() {
    # read -n1 -p 'Are you sure to remove all container?(y/n)' ans
    echo -n "Are you sure to remove all container?(y/n): "
    read ans
    case $ans in
    y | Y)
        docker rm $(docker ps -a -q)
        ;;
    n | N)
        echo "exit"
        ;;
    *)
        echo "no effect and exit"
        ;;
    esac
}

# Stop and Remove all containers
alias drmf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'

# Remove all images
dri() {
    echo -n "Are you sure to remove all images?(y/n): "
    read ans
    case $ans in
    y | Y)
        docker rmi $(docker images -q)
        ;;
    n | N)
        echo "exit"
        ;;
    *)
        echo "no effect and exit"
        ;;
    esac
}

# Delete images
alias drmi='docker rmi'

# show resources status
alias dstats='docker stats'

# Dockerfile build, e.g., $dbu tcnksm/test
alias dbu='docker build -t'

# Show all alias related docker
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/" | sed "s/['|\']//g" | sort; }

# Bash into running container
dbash() { docker exec -it $(docker ps -aqf "name=$1") bash; }

# quick start a container by image name or id
drun() { docker run -it --rm $@ bash; }
