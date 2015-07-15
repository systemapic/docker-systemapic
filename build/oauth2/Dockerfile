##
# systemapic/oauth2
#

# ubuntu + nodejs
FROM systemapic/nodejs


# Copy package.json
ADD ./Oauth2orizeRecipes/authorization-server/package.json /tmp/package.json
WORKDIR /tmp
RUN export MAKEFLAGS="-j 7"
RUN npm install

# copy repo
ADD ./Oauth2orizeRecipes/authorization-server /var/www/oauth2

# copy node_modules
RUN cp /tmp/node_modules /var/www/oauth2/ -r

# inject config
ADD ./oauth2-config.js /var/www/oauth2/config/index.js

# inject certs
ADD ./systemapic_com.crt /var/www/oauth2/certs/
ADD ./systemapic_com.key /var/www/oauth2/certs/

# define working directory.
WORKDIR /var/www/oauth2

# Expose port
EXPOSE 3000

# Define default command.
CMD ["node app.js"]