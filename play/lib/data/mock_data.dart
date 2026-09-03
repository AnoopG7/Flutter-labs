import 'package:flutter/material.dart';

import '../models/movie.dart';

class Category {
  final String name;
  final IconData icon;

  const Category({required this.name, required this.icon});
}

const List<Category> movieCategories = [
  Category(name: 'Action', icon: Icons.local_fire_department),
  Category(name: 'Comedy', icon: Icons.theater_comedy),
  Category(name: 'Sci-Fi', icon: Icons.rocket_launch),
  Category(name: 'Drama', icon: Icons.movie_filter),
  Category(name: 'Thriller', icon: Icons.remove_red_eye),
];

const List<Movie> allMovies = [
  Movie(
    id: 'm1',
    title: 'Midnight Heist',
    category: 'Action',
    year: '2024',
    rating: 8.2,
    duration: '2h 08m',
    description:
        'A master thief assembles a crew to pull off the impossible: stealing '
        'a priceless artefact from a heavily guarded vault in 60 minutes.',
    imageUrl: 'https://picsum.photos/seed/midnight-heist/300/450',
  ),
  Movie(
    id: 'm2',
    title: 'Thunder Ridge',
    category: 'Action',
    year: '2023',
    rating: 7.6,
    duration: '1h 55m',
    description:
        'A retired soldier must defend a small mountain town from an armed '
        'gang as a storm cuts off the only road out.',
    imageUrl: 'https://picsum.photos/seed/thunder-ridge/300/450',
  ),
  Movie(
    id: 'm3',
    title: 'Laugh Track',
    category: 'Comedy',
    year: '2024',
    rating: 7.9,
    duration: '1h 42m',
    description:
        'A struggling comedian discovers that the audience can only hear his '
        'jokes when he is completely panicking on stage.',
    imageUrl: 'https://picsum.photos/seed/laugh-track/300/450',
  ),
  Movie(
    id: 'm4',
    title: 'Roommates of Chaos',
    category: 'Comedy',
    year: '2022',
    rating: 6.8,
    duration: '1h 38m',
    description:
        'Three strangers, one crumbling apartment, and a lease none of them '
        'can afford to break. Hilarity follows.',
    imageUrl: 'https://picsum.photos/seed/roommates-chaos/300/450',
  ),
  Movie(
    id: 'm5',
    title: 'Orbital',
    category: 'Sci-Fi',
    year: '2025',
    rating: 8.7,
    duration: '2h 21m',
    description:
        'A lone astronaut stranded above a dying Earth must decide between '
        'returning home and continuing a one-way mission to save the species.',
    imageUrl: 'https://picsum.photos/seed/orbital/300/450',
  ),
  Movie(
    id: 'm6',
    title: 'The Glass City',
    category: 'Sci-Fi',
    year: '2023',
    rating: 7.2,
    duration: '2h 05m',
    description:
        'In a future where memories are traded like currency, a detective '
        'hunts a thief who stole an entire lifetime of recollections.',
    imageUrl: 'https://picsum.photos/seed/glass-city/300/450',
  ),
  Movie(
    id: 'm7',
    title: 'Quiet Letters',
    category: 'Drama',
    year: '2024',
    rating: 8.4,
    duration: '2h 12m',
    description:
        'A letter-writer in a small village becomes the reluctant keeper of '
        'secrets that reshape three generations of a family.',
    imageUrl: 'https://picsum.photos/seed/quiet-letters/300/450',
  ),
  Movie(
    id: 'm8',
    title: 'Paper Planes',
    category: 'Drama',
    year: '2021',
    rating: 7.1,
    duration: '1h 48m',
    description:
        'Two brothers reconnect through their late father\u2019s unfinished '
        'hobby, folding origami that seems to carry his final message.',
    imageUrl: 'https://picsum.photos/seed/paper-planes/300/450',
  ),
  Movie(
    id: 'm9',
    title: 'Crosshair',
    category: 'Thriller',
    year: '2025',
    rating: 8.0,
    duration: '1h 59m',
    description:
        'A bodyguard realises her own client is the target of a conspiracy '
        'she accidentally set in motion days earlier.',
    imageUrl: 'https://picsum.photos/seed/crosshair/300/450',
  ),
  Movie(
    id: 'm10',
    title: 'The Red Envelope',
    category: 'Thriller',
    year: '2023',
    rating: 7.5,
    duration: '1h 52m',
    description:
        'An investment banker receives a red envelope that predicts his every '
        'move one day in advance. The seventh one predicts a funeral.',
    imageUrl: 'https://picsum.photos/seed/red-envelope/300/450',
  ),
  Movie(
    id: 'm11',
    title: 'Neon Alley',
    category: 'Sci-Fi',
    year: '2024',
    rating: 7.8,
    duration: '2h 02m',
    description:
        'A courier in a neon-soaked city discovers a package that contains '
        'the city\u2019s only true map of itself.',
    imageUrl: 'https://picsum.photos/seed/neon-alley/300/450',
  ),
  Movie(
    id: 'm12',
    title: 'The Last Reel',
    category: 'Drama',
    year: '2022',
    rating: 7.4,
    duration: '1h 47m',
    description:
        'A retired film editor rebuilds a lost classic frame by frame to '
        'prove her late mentor was not the fraud everyone believes.',
    imageUrl: 'https://picsum.photos/seed/last-reel/300/450',
  ),
];