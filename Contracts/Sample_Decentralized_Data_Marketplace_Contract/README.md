# Decentralized Data Marketplace: Powering Data-Driven Decisions

This repository contains a Solidity smart contract designed for a decentralized data marketplace. It enables the creation, buying, and selling of data assets, ensuring secure and transparent transactions using blockchain technology.

## Contract Overview

### DataAsset Struct

Represents the data asset, including:

- **Name:** The name of the data asset.
- **Description:** A brief description of the data asset.
- **Owner:** The Ethereum address of the asset's owner.
- **Price:** The price (in Ether) set by the owner for selling the asset.
- **Data Hash:** The storage hash (e.g., IPFS) where the data is stored.

### Mappings and Counters

- **dataAssets Mapping:** Stores data assets, indexed by their unique IDs.
- **assetCount:** Keeps track of the number of data assets created.

### Events

Logs important actions, including:

- **DataAssetCreated:** Creation of a data asset, including asset ID, name, and owner.
- **DataAssetForSale:** Putting a data asset up for sale, including asset ID and price.
- **DataAssetSold:** Sale of a data asset, including asset ID, buyer, and price.

### Modifiers

- **onlyOwner:** Ensures that only the owner of a data asset can perform certain actions, such as putting the asset up for sale or removing it from sale.

## Functions

- **createDataAsset:** Allows users to create a new data asset.
- **putAssetForSale:** Lets the owner put their data asset up for sale at a specified price.
- **buyDataAsset:** Allows a buyer to purchase the asset by sending the required Ether.
- **getDataAsset:** Retrieves the details of a data asset.
- **removeFromSale:** Allows the owner to remove their data asset from the marketplace.

## Usage

### Data Creation

A user creates a data asset by providing a name, description, and data hash. The owner is automatically set to the user who creates the asset.

### Selling Data

The owner can set a price and put the data asset up for sale.

### Buying Data

Any user can buy the data asset by sending the required Ether, which is transferred to the original owner.
