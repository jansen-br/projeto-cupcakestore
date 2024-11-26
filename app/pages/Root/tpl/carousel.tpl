<div id="cpCarousel" class="carousel slide carousel-fade" data-bs-ride="carousel">
    <div class="carousel-indicators">
        <button type="button" data-bs-target="#cpCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
        <button type="button" data-bs-target="#cpCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
        <button type="button" data-bs-target="#cpCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
    </div>
    <div class="carousel-inner">
        <div class="carousel-item active" data-bs-interval="5000" style="--cp-bg-url: url('<?= $router->route('root'); ?>/assets/img/frame1.jpg')"></div>
        <div class="carousel-item" data-bs-interval="5000" style="--cp-bg-url: url('<?= $router->route('root'); ?>/assets/img/frame2.jpg')"></div>
        <div class="carousel-item" style="--cp-bg-url: url('<?= $router->route('root'); ?>/assets/img/frame3.jpg')"></div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#cpCarousel" data-bs-slide="prev">
        <span class="carousel-control-prev-icon"></span>
        <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#cpCarousel" data-bs-slide="next">
        <span class="carousel-control-next-icon"></span>
        <span class="visually-hidden">Next</span>
    </button>
</div>