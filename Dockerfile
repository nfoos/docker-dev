FROM alpine

RUN set -ex && \
	apk update && \
	apk upgrade && \
	apk add --no-cache \
		ack \
		git \
		nodejs \
		python3 \
		ruby \
		elixir \
		vim

# postgresql-client, sqlite3

RUN set -ex && \
	apk add --no-cache --virtual .build-deps nodejs-npm && \
	npm -g install live-server && \
	npm -g install js-beautify && \
	npm -g install prettier @prettier/plugin-ruby && \
	apk del --no-cache .build-deps

# RUN set -ex && \
#     apk add --no-cache --virtual .build-deps wget make perl-app-cpanminus && \
#     cpanm -n Perl::Tidy && \
#     apk del --no-cache .build-deps

# RUN pip3 install --no-cache-dir --upgrade pip \
#     autopep8 \
#     httpie \
#     pytest \
#     pytest-cov \
#     pytest-django

RUN set -ex && \
	apk add --no-cache --virtual .build-deps libc-dev gcc make ruby-dev && \
	gem install etc json htmlbeautifier rubocop:'0.65.0' rubocop-rspec --no-document && \
	apk del --no-cache .build-deps

ARG UID=1000
ARG GID=1000

ENV USER dev
ENV HOME /home/$USER
WORKDIR $HOME

RUN set -ex && \
	addgroup -g $GID $USER && \
	adduser -u $UID -h $HOME -G $USER -D $USER && \
	chown -R $USER:$USER $HOME


WORKDIR /opt/dev
COPY gitconfig gitignore perltidyrc rubocop.yml vimrc ./
COPY git-hooks git-hooks/
COPY vim vim/
RUN chown -R $USER:$USER /opt/dev
USER $USER

ENV VIMINIT ":source /opt/dev/vimrc"
ENV MYVIMRTP /opt/dev/vim
ENV MYVIMRC /opt/dev/vimrc
RUN set -ex && \
	git clone https://github.com/VundleVim/Vundle.vim.git vim/bundle/Vundle.vim && \
	vim +PluginInstall +qall

WORKDIR /src

CMD ["/bin/ash", "--login"]
