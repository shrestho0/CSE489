List<int> calculateCoinCount(List<int> takaTypes, int taka) {
  var takaCounts = [0, 0, 0, 0, 0, 0, 0, 0];

  for (var i = 0; i < takaTypes.length; i++) {
    var coinCount = taka ~/ takaTypes[i];
    taka = taka % takaTypes[i];
    print("Coin ${takaTypes[i]} $coinCount");
  }

  return takaCounts;
}

void main(List<String> args) {
  const xx = [500, 100, 50, 20, 10, 5, 2, 1];
  var takaCountList = calculateCoinCount(xx, 105);
  print("TakaList: ${takaCountList}");
}
