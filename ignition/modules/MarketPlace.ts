import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const MarketPlace = buildModule("MarketPlace", (m) => {
  const marketPlace = m.contract("MarketPlace");

  return { marketPlace };
});

export default MarketPlace;
