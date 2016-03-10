[![Builld Status](https://snap-ci.com/raigons/parser/branch/master/build_image)](https://snap-ci.com/raigons/parser/branch/master)

# WhatsappParser

WhatsappParser is a pure Ruby app where you can parse your txt conversations and extract some numbers from it, like:

  - Number of messages per user in chat;
  - Number of messages per hour per user;
  - Number of messages per day per user;

It is not completed yet, and we have a lot more todo and try more statics...

### Setup

To run a base environment you can opt to use [Vagrant] in order to start a virtual machine. In our `Vagrantfile` we use `ubuntu trusty 64` as a linux box.

Just do a

```sh
  $ vagrant up
```
and you will be provisioned. So you can do a ssh into this VM and run rakes and tests there.

### Running your tests

We use [rspec] as test lib

[vagrant]: <https://www.vagrantup.com/>
[rspec]: <http://rspec.info/>
