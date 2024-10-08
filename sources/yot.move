module yot::yot {
    use sui::coin::{Self, TreasuryCap, Coin};
    use sui::url::{Self, Url};

    public struct YOT has drop {}

    fun init(witness: YOT, ctx: &mut TxContext) {
        let (treasury, metadata) = coin::create_currency(
            witness,
            6,
            b"YOT",
            b"YO Token",
            b"YOT is the native token of Yield Optimization Terminal.",
            option::some<Url>(
                url::new_unsafe_from_bytes(
                    b"https://mqer437zuw4u4ntyk5aftetyb4fbwuzvvaygwpfuk5mw6w75dkna.arweave.net/ZAkeb_mluU42eFdAWZJ4DwobUzWoMGs8tFdZb1v9Gpo"
                )
            ),
            ctx
        );
        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury, ctx.sender());
    }

    public fun mint(
        treasury_cap: &mut TreasuryCap<YOT>,
        amount: u64,
        recipient: address,
        ctx: &mut TxContext,
    ) {
        let coin = coin::mint(treasury_cap, amount, ctx);
        transfer::public_transfer(coin, recipient)
    }

    public fun burn(
        treasury_cap: &mut TreasuryCap<YOT>,
        coin: Coin<YOT>,
    ): u64 {
        coin::burn(treasury_cap, coin)
    }
}
