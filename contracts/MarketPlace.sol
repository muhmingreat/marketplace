// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MarketPlace {
    struct Item {
        string name;
        uint256 price;
        address payable seller;
        bool isAvailable;
    }

    Item[] public items;

    event ItemListed(uint256 indexed itemId, string name, uint256 price, address indexed seller);
    event ItemPurchased(uint256 indexed itemId, address indexed buyer, uint256 price);

    // Function to add an item for sale
    function listItem(string calldata _name, uint256 _price) external {
        require(_price > 0, "Price must be greater than zero");

        items.push(Item({
            name: _name,
            price: _price,
            seller: payable(msg.sender),
            isAvailable: true
        }));

        emit ItemListed(items.length - 1, _name, _price, msg.sender);
    }

    // Function to purchase an item
    function purchaseItem(uint256 _itemId) external payable {
        require(_itemId < items.length, "Invalid item ID");
        Item storage item = items[_itemId];
        require(item.isAvailable, "Item not available for sale");
        require(msg.value == item.price, "Incorrect ETH amount sent");

        // Mark the item as sold
        item.isAvailable = false;

        // Transfer the funds to the seller
        item.seller.transfer(msg.value);

        emit ItemPurchased(_itemId, msg.sender, item.price);
    }

    // Function to get item details
    function getItem(uint256 _itemId) external view returns (string memory name, uint256 price, address seller, bool isAvailable) {
        require(_itemId < items.length, "Invalid item ID");
        Item storage item = items[_itemId];
        return (item.name, item.price, item.seller, item.isAvailable);
    }

    // Function to get the total number of items
    function getItemCount() external view returns (uint256) {
        return items.length;
    }
}
