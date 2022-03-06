FROM python:3.9.8

WORKDIR /app

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get upgrade -y

RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    git \
    build-essential \
    make \
    wget \
    curl \
    vim \
    htop

RUN pip3 install --upgrade pip \
    && pip3 install poetry \
    && poetry config virtualenvs.create true

COPY pyproject.toml /app
COPY poetry.lock /app
RUN poetry install

# git completion
RUN wget \
  https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash \
  -O ~/.git-completion.bash
RUN chmod a+x ~/.git-completion.bash
RUN echo "source ~/.git-completion.bash" >> ~/.bashrc
