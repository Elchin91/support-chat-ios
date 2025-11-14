Convert the below HTML/CSS code into React component. Do not include the global components as these already exist:

<div class="min-h-screen bg-gray-50 pb-20">
  <!-- Status Bar Spacer -->
  <div class="h-11"></div>
  
  <!-- Header -->
  <header id="header-mobile" class="bg-gray-50 px-4 py-4 flex items-center justify-between">
    <h1 class="text-3xl font-bold text-gray-900">Сервисы</h1>
    <button class="min-h-[48px] min-w-[48px] flex items-center justify-center">
      <i class="fa-solid fa-magnifying-glass text-2xl text-gray-900"></i>
    </button>
  </header>

  <!-- Main Content -->
  <main id="main-content" class="px-4">
    
    <!-- New Services Cards -->
    <section id="section-new-services" class="mb-6">
      <div class="flex gap-3 overflow-x-auto pb-2 -mx-4 px-4">
        <div class="min-w-[160px] bg-white rounded-2xl p-4 shadow-sm">
          <span class="inline-block bg-green-500 text-white text-xs font-semibold px-3 py-1 rounded-full mb-3">Новинка</span>
          <h3 class="text-lg font-bold text-gray-900 mb-1">Мой<br>гараж</h3>
          <img src="https://images.pexels.com/photos/3802510/pexels-photo-3802510.jpeg?auto=compress&cs=tinysrgb&w=800" alt="Car" class="w-full h-20 object-cover rounded-lg mt-2">
        </div>
        <div class="min-w-[160px] bg-white rounded-2xl p-4 shadow-sm">
          <span class="inline-block bg-green-500 text-white text-xs font-semibold px-3 py-1 rounded-full mb-3">Новинка</span>
          <h3 class="text-lg font-bold text-gray-900 mb-1">Кабинет<br>Azeriqaz</h3>
          <img src="https://images.pexels.com/photos/414928/pexels-photo-414928.jpeg?auto=compress&cs=tinysrgb&w=800" alt="Meter" class="w-full h-20 object-cover rounded-lg mt-2">
        </div>
      </div>
    </section>

    <!-- My Payments Section -->
    <section id="section-payments" class="mb-6">
      <div class="flex items-center justify-between mb-4">
        <h2 class="text-2xl font-bold text-gray-900">Мои платежи</h2>
        <button class="flex items-center gap-1 text-gray-900 font-medium min-h-[48px]">
          <span>Все</span>
          <i class="fa-solid fa-chevron-right text-sm"></i>
        </button>
      </div>
      
      <div class="flex gap-3 overflow-x-auto pb-2 -mx-4 px-4">
        <div class="min-w-[110px] bg-white rounded-2xl p-4 shadow-sm text-center">
          <div class="w-16 h-16 bg-blue-100 rounded-2xl flex items-center justify-center mx-auto mb-3">
            <i class="fa-solid fa-mobile-screen-button text-2xl text-blue-500"></i>
          </div>
          <p class="text-sm font-semibold text-gray-900">Мой<br>номер</p>
        </div>
        
        <div class="min-w-[110px] bg-white rounded-2xl p-4 shadow-sm text-center">
          <div class="w-16 h-16 bg-purple-600 rounded-2xl flex items-center justify-center mx-auto mb-3">
            <svg class="w-8 h-8 text-white" viewBox="0 0 40 40" fill="currentColor">
              <path d="M8 12 Q8 8 12 8 L28 8 Q32 8 32 12 L32 28 Q32 32 28 32 L12 32 Q8 32 8 28 Z M15 18 L25 22 L15 26 Z"/>
            </svg>
          </div>
          <p class="text-xs font-semibold text-gray-900 mb-1">Azercell</p>
          <p class="text-xs text-gray-500">102533806</p>
        </div>
        
        <div class="min-w-[110px] bg-white rounded-2xl p-4 shadow-sm text-center">
          <div class="w-16 h-16 bg-purple-600 rounded-2xl flex items-center justify-center mx-auto mb-3">
            <svg class="w-8 h-8 text-white" viewBox="0 0 40 40" fill="currentColor">
              <path d="M8 12 Q8 8 12 8 L28 8 Q32 8 32 12 L32 28 Q32 32 28 32 L12 32 Q8 32 8 28 Z M15 18 L25 22 L15 26 Z"/>
            </svg>
          </div>
          <p class="text-xs font-semibold text-gray-900 mb-1">Azercell</p>
          <p class="text-xs text-gray-500">505199991</p>
        </div>
      </div>
    </section>

    <!-- Services List -->
    <section id="section-services-list" class="space-y-3">
      
      <button class="w-full bg-white rounded-2xl p-4 shadow-sm flex items-center justify-between min-h-[72px]">
        <div class="flex items-center gap-4">
          <div class="w-12 h-12 flex items-center justify-center">
            <i class="fa-solid fa-mobile-screen text-3xl text-cyan-400"></i>
          </div>
          <span class="text-base font-semibold text-gray-900">Мобильные операторы</span>
        </div>
        <div class="flex items-center gap-2">
          <span class="bg-blue-500 text-white text-xs font-bold px-2 py-1 rounded-full flex items-center gap-1">
            <i class="fa-solid fa-droplet text-xs"></i>
            2%
          </span>
        </div>
      </button>

      <button class="w-full bg-white rounded-2xl p-4 shadow-sm flex items-center justify-between min-h-[72px]">
        <div class="flex items-center gap-4">
          <div class="w-12 h-12 flex items-center justify-center">
            <i class="fa-solid fa-house text-3xl text-cyan-400"></i>
          </div>
          <span class="text-base font-semibold text-gray-900">Коммунальные услуги</span>
        </div>
        <div class="flex items-center gap-2">
          <span class="bg-blue-500 text-white text-xs font-bold px-2 py-1 rounded-full flex items-center gap-1">
            <i class="fa-solid fa-droplet text-xs"></i>
            2%
          </span>
        </div>
      </button>

      <button class="w-full bg-white rounded-2xl p-4 shadow-sm flex items-center justify-between min-h-[72px]">
        <div class="flex items-center gap-4">
          <div class="w-12 h-12 flex items-center justify-center">
            <i class="fa-solid fa-credit-card text-3xl text-cyan-400"></i>
          </div>
          <span class="text-base font-semibold text-gray-900">BakiKart</span>
        </div>
      </button>

      <button class="w-full bg-white rounded-2xl p-4 shadow-sm flex items-center justify-between min-h-[72px]">
        <div class="flex items-center gap-4">
          <div class="w-12 h-12 flex items-center justify-center">
            <i class="fa-solid fa-building-columns text-3xl text-cyan-400"></i>
          </div>
          <span class="text-base font-semibold text-gray-900">Банковские услуги</span>
        </div>
        <div class="w-12 h-12 bg-cyan-400 rounded-full flex items-center justify-center">
          <i class="fa-solid fa-lemon text-2xl text-yellow-300"></i>
        </div>
      </button>

    </section>
  </main>

  <!-- Bottom Tab Bar -->
  <nav id="tab-bar" class="fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200 px-2 pt-2 pb-6">
    <div class="flex items-center justify-around">
      <button class="flex flex-col items-center gap-1 min-w-[60px] py-2">
        <i class="fa-solid fa-house text-xl text-gray-400"></i>
        <span class="text-xs text-gray-500">Главная</span>
      </button>
      <button class="flex flex-col items-center gap-1 min-w-[60px] py-2">
        <i class="fa-solid fa-wallet text-xl text-gray-900"></i>
        <span class="text-xs text-gray-900 font-semibold">Платежи</span>
      </button>
      <button class="flex flex-col items-center gap-1 min-w-[60px] py-2">
        <i class="fa-solid fa-qrcode text-xl text-gray-400"></i>
        <span class="text-xs text-gray-500">QR</span>
      </button>
      <button class="flex flex-col items-center gap-1 min-w-[60px] py-2">
        <i class="fa-regular fa-clock text-xl text-gray-400"></i>
        <span class="text-xs text-gray-500">История</span>
      </button>
      <button class="flex flex-col items-center gap-1 min-w-[60px] py-2">
        <i class="fa-regular fa-user text-xl text-gray-400"></i>
        <span class="text-xs text-gray-500">Профиль</span>
      </button>
    </div>
  </nav>
</div>