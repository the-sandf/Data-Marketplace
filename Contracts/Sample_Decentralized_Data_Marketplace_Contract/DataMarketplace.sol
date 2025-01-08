// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract DataMarketplace {

    // Struct to represent a Data Asset
    struct DataAsset {
        string name;
        string description;
        address owner;
        uint256 price;
        string dataHash;  // IPFS or other decentralized storage hash
        bool isForSale;
    }

    // Mapping of data assets by their ID
    mapping(uint256 => DataAsset) private  dataAssets;
    uint256 public assetCount;

    // Events
    event DataAssetCreated(uint256 indexed assetId, string name, address indexed owner);
    event DataAssetForSale(uint256 indexed assetId, uint256 price);
    event DataAssetSold(uint256 indexed assetId, address indexed buyer, uint256 price);

    // Modifier to check asset ownership
    modifier onlyOwner(uint256 assetId) {
        require(dataAssets[assetId].owner == msg.sender, "Not the owner");
        _;
    }

    // Create a new data asset
    function createDataAsset(string memory _name, string memory _description, string memory _dataHash) public {
        assetCount++;
        dataAssets[assetCount] = DataAsset({
            name: _name,
            description: _description,
            owner: msg.sender,
            price: 0,
            dataHash: _dataHash,
            isForSale: false
        });

        emit DataAssetCreated(assetCount, _name, msg.sender);
    }

    // Put a data asset up for sale
    function putAssetForSale(uint256 assetId, uint256 _price) public onlyOwner(assetId) {
        DataAsset storage asset = dataAssets[assetId];
        asset.price = _price;
        asset.isForSale = true;

        emit DataAssetForSale(assetId, _price);
    }

    // Buy a data asset
    function buyDataAsset(uint256 assetId) public payable {
        DataAsset storage asset = dataAssets[assetId];
        require(asset.isForSale, "Asset not for sale");
        require(msg.value >= asset.price, "Insufficient payment");

        // Transfer ownership and funds
        address previousOwner = asset.owner;
        asset.owner = msg.sender;
        asset.isForSale = false;

        payable(previousOwner).transfer(msg.value);

        emit DataAssetSold(assetId, msg.sender, asset.price);
    }

    // Retrieve asset data
    function getDataAsset(uint256 assetId)
        public
        view
        returns (
            string memory,
            string memory,
            address,
            uint256,
            bool
        )
    {
        DataAsset memory asset = dataAssets[assetId];
        return (
            asset.name,
            asset.description,
            asset.owner,
            asset.price,
            asset.isForSale
        );
    }

    function getDataHash(uint256 assetId) public view returns (string memory) {
        require(dataAssets[assetId].owner == msg.sender, "Not the asset owner");
        return dataAssets[assetId].dataHash;
    }

    // Remove a data asset from sale
    function removeFromSale(uint256 assetId) public onlyOwner(assetId) {
        DataAsset storage asset = dataAssets[assetId];
        asset.isForSale = false;
    }
}
