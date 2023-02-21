require("@nomiclabs/hardhat-waffle");
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
      console.log(account.address);
  }
});
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.4",
  networks: {
    goerli: {
      url: "https://old-solemn-glitter.ethereum-goerli.discover.quiknode.pro/1eb9f6157f5019f1fc949619fda73b626291e194/",
      accounts: ["864d20ee5cfce23fcf676058339119ee355dacb770302bfb8d39bd8f7f253644"]
    },
  },
};