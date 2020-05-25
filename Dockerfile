FROM ruby:2.6

# Install Rails dependencies for the OS
RUN apt-get update && apt-get install -y libpq-dev postgresql-client nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Set the work directory inside container
RUN mkdir /app
WORKDIR /app

# Copy all the rest inside work directory
COPY . /app

RUN echo "gem: --no-document" >> ~/.gemrc

# Copy the Gemfile inside the container
COPY Gemfile* /app/

# Install the Gems
RUN gem install bundler
RUN bundle install --jobs 32 --retry 4

# Copy all the rest inside work directory
COPY . /app
