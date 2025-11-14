Convert the below HTML/CSS code into React components:

<div class="min-h-screen bg-gradient-to-br from-cyan-400 via-teal-400 to-emerald-400 pb-20" id="main-content">
  <div class="pt-11 px-4">
    <div class="flex items-center justify-between mb-6">
      <div class="text-sm font-semibold">06:27 <i class="fa-solid fa-location-arrow ml-1"></i></div>
      <div class="flex items-center gap-2">
        <i class="fa-solid fa-signal text-sm"></i>
        <i class="fa-solid fa-wifi text-sm"></i>
        <div class="bg-white text-black px-2 py-0.5 rounded text-xs font-bold">100</div>
      </div>
    </div>

    <div class="flex items-center gap-3 mb-6">
      <div class="w-12 h-12 bg-white rounded-2xl flex items-center justify-center">
        <i class="fa-solid fa-qrcode text-2xl"></i>
      </div>
      <div class="text-xl font-bold">Мой QR</div>
    </div>

    <div class="bg-white rounded-3xl p-6 mb-4 shadow-lg">
      <div class="text-gray-500 text-sm mb-2">Доступно</div>
      <div class="flex items-end justify-between mb-6">
        <div class="flex items-end">
          <div class="text-5xl font-bold">39</div>
          <div class="text-3xl text-gray-400 ml-1">.57</div>
          <i class="fa-solid fa-manat-sign text-2xl text-gray-400 ml-2"></i>
        </div>
        <button class="w-10 h-10 bg-gray-100 rounded-full flex items-center justify-center">
          <i class="fa-solid fa-eye-slash text-gray-400"></i>
        </button>
      </div>
      <div class="grid grid-cols-2 gap-3">
        <button class="bg-gray-900 text-white rounded-2xl py-4 font-semibold flex items-center justify-center gap-2">
          <i class="fa-solid fa-plus"></i> Пополнить
        </button>
        <button class="bg-gray-900 text-white rounded-2xl py-4 font-semibold flex items-center justify-center gap-2">
          <i class="fa-solid fa-arrow-up-right-from-square"></i> Перевести
        </button>
      </div>
    </div>

    <div class="bg-white rounded-3xl p-5 mb-4 shadow-lg flex items-center justify-between">
      <div class="flex items-center gap-4">
        <i class="fa-solid fa-receipt text-3xl text-blue-600"></i>
        <div>
          <div class="font-bold text-lg">Мои платежи</div>
          <div class="text-gray-500 text-sm">8 сохраненных платежей</div>
        </div>
      </div>
      <i class="fa-solid fa-chevron-right text-gray-400"></i>
    </div>

    <div class="flex gap-3 overflow-x-auto pb-4 mb-4 scrollbar-hide">
      <div class="min-w-[160px] bg-blue-900 rounded-3xl p-4 border-4 border-blue-700">
        <div class="text-white text-sm font-semibold mb-2">Пожертвова<br>ние в фонд<br>«YAŞAT»</div>
        <div class="text-yellow-400 text-2xl">💛</div>
      </div>
      <div class="min-w-[160px] bg-white rounded-3xl p-4 border-4 border-blue-400">
        <div class="text-sm font-semibold mb-2">Скоро!<br>Переводы за<br>границу</div>
        <div class="text-4xl">🐋</div>
      </div>
      <div class="min-w-[160px] bg-gradient-to-br from-pink-600 to-pink-500 rounded-3xl p-4 border-4 border-pink-400">
        <div class="text-white text-sm font-semibold mb-2">Лотерея<br>Birmarket</div>
        <div class="text-4xl">💎</div>
      </div>
      <div class="min-w-[160px] bg-gradient-to-br from-lime-300 to-green-200 rounded-3xl p-4 border-4 border-lime-400">
        <div class="text-sm font-semibold mb-2">Переводы в<br>Россию</div>
        <div class="text-4xl">💸</div>
      </div>
    </div>

    <div class="text-gray-600 text-xs uppercase tracking-wide mb-3 font-semibold">НАШИ СЕРВИСЫ</div>

    <div class="grid grid-cols-2 gap-3">
      <div class="bg-gradient-to-br from-blue-600 to-blue-500 rounded-3xl p-6 shadow-lg relative overflow-hidden">
        <div class="text-white font-bold text-lg mb-1">Кредит до</div>
        <div class="text-white font-bold text-2xl">25 000₼</div>
        <div class="absolute bottom-4 right-4 text-6xl">💵</div>
      </div>
      <div class="bg-white rounded-3xl p-6 shadow-lg flex flex-col items-center justify-center">
        <div class="font-bold text-lg mb-3">BakiKart</div>
        <div class="flex gap-2">
          <div class="w-12 h-12 border-4 border-red-500 rounded-xl flex items-center justify-center">
            <i class="fa-solid fa-heart text-red-500 text-xl"></i>
          </div>
          <div class="w-12 h-12 border-4 border-gray-800 rounded-xl flex items-center justify-center">
            <i class="fa-solid fa-qrcode text-gray-800 text-xl"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200 px-4 safe-area-bottom" id="tab-bar">
  <div class="flex items-center justify-around py-2">
    <button class="flex flex-col items-center gap-1 py-2 px-4">
      <i class="fa-solid fa-house text-2xl text-gray-900"></i>
      <span class="text-xs font-semibold text-gray-900">Главная</span>
    </button>
    <button class="flex flex-col items-center gap-1 py-2 px-4">
      <i class="fa-solid fa-wallet text-2xl text-gray-400"></i>
      <span class="text-xs text-gray-400">Платежи</span>
    </button>
    <button class="flex flex-col items-center gap-1 py-2 px-4">
      <i class="fa-solid fa-robot text-2xl text-gray-400"></i>
      <span class="text-xs text-gray-400">AI</span>
    </button>
    <button class="flex flex-col items-center gap-1 py-2 px-4">
      <i class="fa-solid fa-clock-rotate-left text-2xl text-gray-400"></i>
      <span class="text-xs text-gray-400">История</span>
    </button>
    <button class="flex flex-col items-center gap-1 py-2 px-4">
      <i class="fa-solid fa-user text-2xl text-gray-400"></i>
      <span class="text-xs text-gray-400">Профиль</span>
    </button>
  </div>
</div>