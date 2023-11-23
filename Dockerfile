# Rubyの最新安定版イメージを使用
FROM ruby:latest

# 必要なパッケージのインストール
RUN apt-get update -qq && apt-get install -y nodejs

# Railsのインストール
RUN gem install rails

# ワーキングディレクトリの設定
WORKDIR /app

# Gemfileをコンテナにコピー
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# BundlerでGemをインストール
RUN bundle install

# ローカルファイルをコンテナにコピー
COPY . /app
