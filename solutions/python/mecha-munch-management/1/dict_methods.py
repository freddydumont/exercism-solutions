"""Functions to manage a users shopping cart items."""

from collections.abc import Iterable


def add_item(
    current_cart: dict[str, int], items_to_add: Iterable[str]
) -> dict[str, int]:
    """Add items to shopping cart.

    :param current_cart: dict - the current shopping cart.
    :param items_to_add: iterable - items to add to the cart.
    :return: dict - the updated user cart dictionary.
    """

    for item in items_to_add:
        current_cart[item] = current_cart.get(item, 0) + 1

    return current_cart


def read_notes(notes: Iterable[str]):
    """Create user cart from an iterable notes entry.

    :param notes: iterable of items to add to cart.
    :return: dict - a user shopping cart dictionary.
    """

    return dict().fromkeys(notes, 1)


def update_recipes(
    ideas: dict[str, dict[str, int]], recipe_updates: tuple[tuple[str, dict[str, int]]]
) -> dict[str, dict[str, int]]:
    """Update the recipe ideas dictionary.

    :param ideas: dict - The "recipe ideas" dict.
    :param recipe_updates: iterable -  with updates for the ideas section.
    :return: dict - updated "recipe ideas" dict.
    """

    ideas.update(recipe_updates)
    return ideas


def sort_entries(cart: dict[str, int]) -> dict[str, int]:
    """Sort a users shopping cart in alphabetically order.

    :param cart: dict - a users shopping cart dictionary.
    :return: dict - users shopping cart sorted in alphabetical order.
    """

    return dict(sorted(cart.items()))


FulfillmentCartDict = dict[str, list[int | str | bool]]


def send_to_store(
    cart: dict, aisle_mapping: dict[str, list[str | bool]]
) -> FulfillmentCartDict:
    """Combine users order to aisle and refrigeration information.

    :param cart: dict - users shopping cart dictionary.
    :param aisle_mapping: dict - aisle and refrigeration information dictionary.
    :return: dict - fulfillment dictionary ready to send to store.
    """

    cart = {
        item: [cart[item], aisle, is_cold]
        for item, [aisle, is_cold] in aisle_mapping.items()
        if item in cart
    }

    return dict(sorted(cart.items(), reverse=True))


def update_store_inventory(
    fulfillment_cart: FulfillmentCartDict,
    store_inventory: FulfillmentCartDict,
) -> FulfillmentCartDict:
    """Update store inventory levels with user order.

    :param fulfillment cart: dict - fulfillment cart to send to store.
    :param store_inventory: dict - store available inventory
    :return: dict - store_inventory updated.
    """

    updates = {
        item: [
            remaining
            if (remaining := (store_inventory[item][0]) - count) > 0  # pyright: ignore[reportOperatorIssue]
            else "Out of Stock",
            aisle,
            is_cold,
        ]
        for item, [count, aisle, is_cold] in fulfillment_cart.items()
        if item in store_inventory
    }

    return store_inventory | updates
