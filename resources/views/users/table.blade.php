<!DOCTYPE html>
<html>

<head>
    <title>Detective Conan Movie</title>
    <link rel="stylesheet" type="text/css" href="{{ asset('css/web.css') }}">
</head>

<body>
    <h1>Detective Conan Movie</h1>
    <div class="card-container">
        @foreach ($movies as $movie)
            <div class="card" onclick="openPopup('{{ $movie->judul }}', '{{ $movie->sinopsis }}', '{{ $movie->poster }}')">
                @if ($movie->poster)
                    <img src="{{ $movie->poster }}" alt="Movie Poster">
                @else
                    <span>No poster available</span>
                @endif
                <h3>{{ $movie->judul }}</h3>
            </div>
        @endforeach
    </div>

    <!-- Popup container -->
    <div id="popup" class="popup">
        <div class="popup-content">
            <span class="close-btn" onclick="closePopup()">&times;</span>
            <div class="poster">
                <img id="popup-poster" src="" alt="Poster" />
            </div>
            <div class="info">
                <div class="title" id="popup-title"></div>
                <div class="sinopsis" id="popup-sinopsis"></div>
            </div>
        </div>
    </div>

    <script src="{{ asset('js/web.js') }}"></script>
</body>

</html>