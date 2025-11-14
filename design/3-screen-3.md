Convert the below HTML/CSS code into React component. Do not include the global components as these already exist:

<div class="min-h-screen bg-white pb-24">
  <!-- Header -->
  <div id="header-mobile" class="pt-11 px-6 pb-6">
    <h1 class="text-4xl font-bold mb-4">Профиль</h1>
    <p class="text-lg text-gray-700">+994 50 519 99 91</p>
  </div>

  <!-- Main Content -->
  <div id="main-content" class="px-4">
    <!-- Top Cards -->
    <div class="grid grid-cols-2 gap-3 mb-4">
      <div class="bg-gray-100 rounded-2xl p-6 flex flex-col items-start">
        <div class="relative mb-4">
          <div class="w-14 h-14 bg-indigo-600 rounded-full flex items-center justify-center">
            <i class="fa-solid fa-user text-white text-xl"></i>
          </div>
          <div class="absolute -bottom-1 -right-1 w-6 h-6 bg-blue-500 rounded-full flex items-center justify-center">
            <i class="fa-solid fa-check text-white text-xs"></i>
          </div>
        </div>
        <span class="text-base font-medium">Мои данные</span>
      </div>
      
      <div class="bg-gray-100 rounded-2xl p-6 flex flex-col items-start">
        <div class="w-14 h-14 bg-indigo-600 rounded-full flex items-center justify-center mb-4">
          <i class="fa-solid fa-qrcode text-white text-xl"></i>
        </div>
        <span class="text-base font-medium">Мой QR</span>
      </div>
    </div>

    <!-- Menu List -->
    <div class="bg-gray-100 rounded-2xl overflow-hidden">
      <!-- Business -->
      <div class="flex items-center justify-between px-5 py-4 bg-white border-b border-gray-100">
        <div class="flex items-center gap-4">
          <i class="fa-solid fa-briefcase text-2xl"></i>
          <span class="text-base">Ведите свой бизнес с m10</span>
        </div>
        <i class="fa-solid fa-chevron-right text-gray-400"></i>
      </div>

      <!-- Settings -->
      <div class="flex items-center justify-between px-5 py-4 bg-white border-b border-gray-100">
        <div class="flex items-center gap-4">
          <i class="fa-solid fa-gear text-2xl"></i>
          <span class="text-base">Настройки</span>
        </div>
        <i class="fa-solid fa-chevron-right text-gray-400"></i>
      </div>

      <!-- Documents -->
      <div class="flex items-center justify-between px-5 py-4 bg-white border-b border-gray-100">
        <div class="flex items-center gap-4">
          <i class="fa-solid fa-file-lines text-2xl"></i>
          <span class="text-base">Документы</span>
        </div>
        <i class="fa-solid fa-chevron-right text-gray-400"></i>
      </div>

      <!-- Tariffs -->
      <div class="flex items-center justify-between px-5 py-4 bg-white border-b border-gray-100">
        <div class="flex items-center gap-4">
          <i class="fa-solid fa-percent text-2xl"></i>
          <span class="text-base">Тарифы и лимиты</span>
        </div>
        <i class="fa-solid fa-chevron-right text-gray-400"></i>
      </div>

      <!-- Statement -->
      <div class="flex items-center justify-between px-5 py-4 bg-white border-b border-gray-100">
        <div class="flex items-center gap-4">
          <i class="fa-solid fa-receipt text-2xl"></i>
          <span class="text-base">Выписка со счета</span>
        </div>
        <i class="fa-solid fa-chevron-right text-gray-400"></i>
      </div>

      <!-- Support -->
      <div class="flex items-center justify-between px-5 py-4 bg-white border-b border-gray-100">
        <div class="flex items-center gap-4">
          <i class="fa-solid fa-headset text-2xl"></i>
          <span class="text-base">Поддержка</span>
        </div>
        <i class="fa-solid fa-chevron-right text-gray-400"></i>
      </div>

      <!-- Language -->
      <div class="flex items-center justify-between px-5 py-4 bg-white border-b border-gray-100">
        <div class="flex items-center gap-4">
          <div class="w-6 h-6 rounded-full overflow-hidden">
            <svg viewBox="0 0 24 24" class="w-full h-full">
              <rect width="24" height="8" fill="#fff"/>
              <rect y="8" width="24" height="8" fill="#0039a6"/>
              <rect y="16" width="24" height="8" fill="#d52b1e"/>
            </svg>
          </div>
          <div>
            <div class="text-base">Язык</div>
            <div class="text-sm text-gray-500">Русский</div>
          </div>
        </div>
        <i class="fa-solid fa-chevron-right text-gray-400"></i>
      </div>

      <!-- Career -->
      <div class="flex items-center justify-between px-5 py-4 bg-white">
        <div class="flex items-center gap-4">
          <i class="fa-solid fa-user-tie text-2xl text-teal-500"></i>
          <span class="text-base">Карьера в PashaPay</span>
        </div>
        <i class="fa-solid fa-chevron-right text-gray-400"></i>
      </div>
    </div>

    <!-- Logout -->
    <div class="mt-6 px-2">
      <button class="text-base text-gray-700">Выйти из m10</button>
    </div>
  </div>

  <!-- Floating Action Button -->
  <div class="fixed bottom-28 right-6">
    <div class="w-16 h-16 bg-gradient-to-br from-teal-400 to-cyan-500 rounded-full flex items-center justify-center shadow-lg">
      <i class="fa-solid fa-comment text-white text-2xl"></i>
    </div>
  </div>

  <!-- Bottom Tab Bar -->
  <div id="tab-bar" class="fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200 px-2 pt-2 pb-6">
    <div class="flex items-center justify-around">
      <div class="flex flex-col items-center gap-1 py-2 px-4">
        <i class="fa-solid fa-house text-gray-400 text-xl"></i>
        <span class="text-xs text-gray-500">Главная</span>
      </div>
      <div class="flex flex-col items-center gap-1 py-2 px-4">
        <i class="fa-solid fa-credit-card text-gray-400 text-xl"></i>
        <span class="text-xs text-gray-500">Платежи</span>
      </div>
      <div class="flex flex-col items-center gap-1 py-2 px-4">
        <i class="fa-solid fa-qrcode text-gray-400 text-xl"></i>
        <span class="text-xs text-gray-500">QR</span>
      </div>
      <div class="flex flex-col items-center gap-1 py-2 px-4">
        <i class="fa-solid fa-clock-rotate-left text-gray-400 text-xl"></i>
        <span class="text-xs text-gray-500">История</span>
      </div>
      <div class="flex flex-col items-center gap-1 py-2 px-4">
        <i class="fa-solid fa-user text-gray-900 text-xl"></i>
        <span class="text-xs text-gray-900 font-medium">Профиль</span>
      </div>
    </div>
  </div>
</div>