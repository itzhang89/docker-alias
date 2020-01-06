# ------------------------------------
# Docker alias and function
# ------------------------------------

# Get latest container ID
alias dl="docker ps -l -q"

# Get container process
alias dps="docker ps"
# Get process included stop container
alias dpsa="docker ps -a"
# Get process use format and make more simple
alias dpsaf='docker ps -a --format "table {{.ID}} {{.Names}}\t{{.Image}}\t{{.Status}}"'

# Get images
alias di="docker images"

# Get container
alias dc='docker container'

# Get network
alias dnet='docker network'

# Get container IP
alias dip="docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"

# Run deamonized container, e.g., $dkd base /bin/echo hello
alias dkd="docker run -d -P"

# Run interactive container, e.g., $dki base /bin/bash
alias dki="docker run -i -t -P"

# Execute interactive container, e.g., $dex base /bin/bash
alias dex="docker exec -i -t"

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
        y | Y) docker rm $(docker ps -a -q)
        ;;
        n | N) echo "exit"
        ;;
        *) echo "no effect and exit"
        ;;
    esac
}

# Stop and Remove all containers
alias drmf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'

# Remove all images
dri() { docker rmi $(docker images -q); }

# Dockerfile build, e.g., $dbu tcnksm/test
dbu() { docker build -t=$1 .; }

# Show all alias related docker
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/" | sed "s/['|\']//g" | sort; }

# Bash into running container
dbash() { docker exec -it $(docker ps -aqf "name=$1") bash; }
