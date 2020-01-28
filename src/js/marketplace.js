Marketplace = {
  web3Provider: null,
  contracts: {},
  account: '0x0',

  init: function() {
    console.log("init giani giani gianid dsgds called");
    return Marketplace.initWeb3();
  },

  initWeb3: function() {
    console.log("------------")
    console.log("inceput initweb3")
    if (typeof web3 !== 'undefined') {
      // If a web3 instance isth already provided by Meta Mask.
      Marketplace.web3Provider = web3.currentProvider;
      ethereum.enable();

     // Marketplace.web3Provider = new Web3.providers.HttpProvider('http://localhost:7545');
      
      web3 = new Web3(web3.currentProvider);
    } else {
      // Specify default instance if no web3 instance provided
      Marketplace.web3Provider = new Web3.providers.HttpProvider('http://localhost:7545');
      ethereum.enable();

      web3 = new Web3(Marketplace.web3Provider);
    }
    console.log("am ajuns aicisa");
    return Marketplace.initMarketplace();
  },

  initMarketplace: function() {
    $.getJSON("Marketplace.json", function(marketplace) {
      // Instantiate a new truffle contract from the artifact
      Marketplace.contracts.Marketplace = TruffleContract(marketplace);
      // Connect provider to interact with contract
      Marketplace.contracts.Marketplace.setProvider(Marketplace.web3Provider);

      return Marketplace.render();
    });
  },

  render: function() {
    var marketplaceInstance;
    //var loader = $("#loader");
    var content = $("#content");

    //loader.show();
    //content.hide();

    // Load account data
    web3.eth.getAccounts(function(error, accounts){
      Marketplace.account = accounts[0];
      console.log("Your Account: " + accounts[0]);
    });

    // Load contract data
    Marketplace.contracts.Marketplace.deployed().then(function(instance) {
      marketplaceInstance = instance;
      console.log("Marketplace count:" + marketplaceInstance.tasksCount());
      return marketplaceInstance.tasksCount();
    }).then(function(candidatesCount) {
      console.log(candidatesCount.toNumber());
    });
  }
    
};

$(function() {
  $(window).load(function() {
    console.log("window load gianina gianina gianina called");
    Marketplace.init();
  });
});