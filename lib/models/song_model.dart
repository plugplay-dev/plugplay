class Song {
  final String title;
  final String artist;
  final String audio;
  final String cover;

  const Song({
    required this.title,
    required this.artist,
    required this.audio,
    required this.cover,
  });
}

final List<Song> demoSongs = [
  Song(
    title: "Abana",
    artist: "Allan Tha Muchacho",
    audio: "music/abana.mp3",
    cover: "images/albums/abana.jpg",
  ),
  Song(
    title: "Amen",
    artist: "Allan Tha Muchacho",
    audio: "music/amen.mp3",
    cover: "images/albums/amen.png",
  ),
  Song(
    title: "Nsekela",
    artist: "Allan Tha Muchacho",
    audio: "music/nsekela.mp3",
    cover: "images/albums/nsekela.jpg",
  ),
  Song(
    title: "Slim Chances",
    artist: "Allan Tha Muchacho",
    audio: "music/slim_chances.mp3",
    cover: "images/albums/slim_chances.png",
  ),
  Song(
    title: "When",
    artist: "Allan Tha Muchacho",
    audio: "music/when.mp3",
    cover: "images/albums/when.png",
  ),
];