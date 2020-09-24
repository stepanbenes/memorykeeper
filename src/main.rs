use walkdir::WalkDir;

fn main() {
    println!("Hello, I am memory keeper! Your personal data backup service.");

    let source_location = "/mnt/blob";
    let _backup_location = "/mnt/bloback";

    let _sync_selection = vec!["hana", "stepan", "hovada", "test/data_sync"];

    let total_size = WalkDir::new(source_location)
        // .min_depth(1)
        // .max_depth(3)
        .into_iter()
        .filter_map(|entry| entry.ok())
        .filter_map(|entry| entry.metadata().ok())
        .filter(|metadata| metadata.is_file())
        .fold(0, |acc, m| acc + m.len());

    println!("Total size: {} bytes.", total_size);

    // TODO: https://rust-lang-nursery.github.io/rust-cookbook/file/dir.html

    // https://raspberrypi.stackexchange.com/questions/8295/external-hard-drive-power-down
    // https://www.raspberrypi.org/documentation/configuration/external-storage.md

}
