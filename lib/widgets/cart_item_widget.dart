import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  const CartItemWidget({Key? key, required CartItem this.cartItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String totalItemValue =
        (cartItem.price! * cartItem.quantity!).toStringAsFixed(2);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Dismissible(
        key: ValueKey(cartItem.id),
        background: Container(
          color: Theme.of(context).colorScheme.error,
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20),
          margin: EdgeInsets.symmetric(vertical: 4),
        ),
        direction: DismissDirection.endToStart,
        confirmDismiss: (_) {
          return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('Você tem certeza?'),
              content: Text('Quer remover o item do carrinho?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('Não'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text('Sim'),
                ),
              ],
            ),
          );
        },
        onDismissed: (_) => Provider.of<Cart>(context, listen: false)
            .removeItem(cartItem.productId),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: ListTile(
              title: Text(cartItem.title!),
              subtitle: Text('Total \$ $totalItemValue'),
              trailing: Text('${cartItem.quantity}x'),
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: FittedBox(
                    child: Text(cartItem.price!.toStringAsFixed(2)),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
