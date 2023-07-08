const hre = require("hardhat");

async function main() {
  const baseURI = "ipfs://QmcyEvXcautKftdeVrYhHLjRrHKbyR4q7cx4vtrouPnzBa/";
  const contractURI = "ipfs://QmXFpCe9JxFP6te6E79Su2wbqZ5YSVPKbhorKfjXX3M9YD";

  const POP = await hre.ethers.getContractFactory("POP");
  const POPDeployed = await POP.deploy(baseURI, contractURI);

  await POPDeployed.deployed();

  console.log("Deployed POP to: ", POPDeployed.address);

  await hre.run("verify:verify", {
    address: POPDeployed.address,
    constructorArguments: [
      baseURI,
      contractURI
    ]
  });
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
